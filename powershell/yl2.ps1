# Skript, mis kustutab Windowsi kasutaja nimega "eesnimi.perenimi"
# Küsi kasutaja nime

Write-Host "1 - Kustuta kasutades nime: (John Doe)"
Write-Host "2 - Kustuta kasutades kasutajanime: (john.doe)"
$valik = Read-Host "Vali number"

if ($valik -eq 1) {
    Write-Host "Valisid 1"
    $kasutaja = Read-Host "Sisesta nimi"
    # Eemalda täpitähed
    $kasutaja = $kasutaja.Replace("ä", "a")
    $kasutaja = $kasutaja.Replace("ö", "o")
    $kasutaja = $kasutaja.Replace("ü", "u")
    $kasutaja = $kasutaja.Replace("õ", "o")
    $kasutaja = $kasutaja.Split(" ")
    $eesnimi = $kasutaja[0]
    $perenimi = $kasutaja[1]
    $lowerkasutaja = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    Remove-LocalUser -Name $lowerkasutaja
    Write-Host "Kasutaja $lowerkasutaja kustutatud!"
} else {
    Write-Host "Valisid 2"
    $kasutaja = Read-Host "Sisesta kasutaja nimi"
    # Eemalada täpitähed
    $kasutaja = $kasutaja.Replace("ä", "a")
    $kasutaja = $kasutaja.Replace("ö", "o")
    $kasutaja = $kasutaja.Replace("ü", "u")
    $kasutaja = $kasutaja.Replace("õ", "o")
    $lowerkasutaja = $kasutaja.ToLower()
    Remove-LocalUser -Name $lowerkasutaja
    Write-Host "Kasutaja $lowerkasutaja kustutatud!"
}