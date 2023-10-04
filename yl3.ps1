# Skript, mis võtab nimekirjast olemas olevad nimed ja teeb need AD kasutajaks, kontrollides kas kasutaja juba on olemas

# Nimekiri inimestest
$inimesed = @("Kristjan Kirsipuu","Kalle Kukk","Malle Mänd","Kätlin Kask")

# Loome AD kasutaja
foreach ($inimene in $inimesed) {
    $eesnimi = $inimene.Split(" ")[0]
    $perenimi = $inimene.Split(" ")[1]
    $kasutaja = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    if (Get-ADUser -Filter {SamAccountName -eq $kasutaja}) {
        Write-Host "Kasutaja $kasutaja on juba olemas!"
    } else {
        New-ADUser -Name $inimene -GivenName "AD" -Surname "$eesnimi $perenimi" -SamAccountName $inimene -UserPrincipalName "$inimene@sv-kool.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "Parool1!" -Force) -Enabled $true
        if ($?) {
            Write-Host "Kasutaja $kasutaja loodud!"
        } else {
            Write-Host "Kasutaja $kasutaja loomine eba6nnestus!"
            Write-Host $Error[0].Exception.Message
            exit
        }
    }
}