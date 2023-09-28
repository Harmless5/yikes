# Skript, mis kustutab Windowsi kasutaja nimega "eesnimi.perenimi"
# Küsi kasutaja nime
$kasutaja = Read-Host "Sisesta kasutaja nimi: "
$lowerkasutaja = $kasutaja.ToLower()
# Kustuta kasutaja
Remove-LocalUser -Name $lowerkasutaja
Write-Host "Kasutaja $lowerkasutaja kustutatud!"