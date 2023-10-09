# Skript, mis kustutab AD kasutajad kasutades nimekirja.

# Nimekiri inimestest
$inimesed = @("Kristjan Tüür","Kalle Kökk","Malle Mänd","Kätlin Kask")

# Kustutame AD kasutajad
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
        Remove-ADUser -Identity $kasutaja
        Write-Host "Kasutaja $kasutaja on kustutatud!" -ForegroundColor green
    } else {
        Write-Host "Kasutaja $kasutaja ei ole olemas!" -ForegroundColor red
    }
}