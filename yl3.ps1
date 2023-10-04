# Skript, mis võtab nimekirjast olemas olevad nimed ja teeb need AD kasutajaks, kontrollides kas kasutaja juba on olemas

# Nimekiri inimestest
$inimesed = @("Kristjan Kirsipuu","Kalle Kukk","Malle Mand","Katlin Kask")

# Loome AD kasutaja
foreach ($inimene in $inimesed) {
    $eesnimi = $inimene.Split(" ")[0]
    $perenimi = $inimene.Split(" ")[1]
    $kasutaja = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    if (Get-ADUser -Filter {SamAccountName -eq $kasutaja}) {
        Write-Host "Kasutaja $kasutaja on juba olemas!" -ForegroundColor red
    } else {
        New-ADUser -Name $kasutaja -GivenName $eesnimi -Surname $perenimi -SamAccountName $kasutaja -UserPrincipalName "$kasutaja@sv-kool.local" -AccountPassword (ConvertTo-SecureString -AsPlainText "Parool1!" -Force) -Enabled $true
        if ($?) {
            Write-Host "Kasutaja $kasutaja ($inimene) loodud!"
        } else {
            Write-Host "Kasutaja $kasutaja loomine eba6nnestus!" -ForegroundColor red
            Write-Host $Error[0].Exception.Message
            exit
        }
    }
}