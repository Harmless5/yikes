# Skript, mis võtab nimekirjast olemas olevad nimed ja teeb need AD kasutajaks, kontrollides kas kasutaja juba on olemas
# Genereerib kasutajatele paroolid ja salvestab kasutajanime ja parooli faili kasutajanimi.csv

# Nimekiri inimestest
$inimesed = @("Kristjan Tüür","Kalle Kökk","Malle Mänd","Kätlin Kask")

# Loome AD kasutaja
foreach ($inimene in $inimesed) {
    # Täpitähtede asendamine
    $inimene = $inimene.Replace("ä","a")
    $inimene = $inimene.Replace("ö","o")
    $inimene = $inimene.Replace("ü","u")
    $inimene = $inimene.Replace("õ","o")
    # ees- ja perenime eraldamine
    $eesnimi = $inimene.Split(" ")[0]
    $perenimi = $inimene.Split(" ")[1]
    # kasutajanime loomine
    $kasutaja = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    if (Get-ADUser -Filter {SamAccountName -eq $kasutaja}) {
        Write-Host "Kasutaja $kasutaja on juba olemas!" -ForegroundColor red
    } else {
        $parool = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 15 | % {[char]$_})
        $hash = ConvertTo-SecureString -String $parool -AsPlainText -Force
        New-ADUser -Name $kasutaja -GivenName $eesnimi -Surname $perenimi -SamAccountName $kasutaja -UserPrincipalName "$kasutaja@sv-kool.local" -AccountPassword $hash -Enabled $true
        Get-ADUser -Identity $kasutaja
        $kasutaja | Select-Object Name, Password | Export-Csv -Path "kasutajanimi.csv" -NoTypeInformation
        if ($?) {
            Write-Host "Kasutaja $kasutaja ($inimene) loodud!"
        } else {
            Write-Host "Kasutaja $kasutaja loomine eba6nnestus!" -ForegroundColor red
            Write-Host $Error[0].Exception.Message
            exit
        }
    }
}