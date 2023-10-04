# Skript, mis kustutab Windowsi kasutaja nimega "eesnimi.perenimi"
# Küsi kasutaja nime

Write-Host "1 - Kustuta kasutades nime: (John Doe)"
Write-Host "2 - Kustuta kasutades kasutajanime: (john.doe)"
Write-Host "3 - Naita kasutajaid"
$valik = Read-Host "Vali number"

if ($valik -eq 1) {
    #Write-Host "Valisid 1"
    $kasutaja = Read-Host "Sisesta nimi"
    $kasutaja = $kasutaja.Split(" ")
    $eesnimi = $kasutaja[0]
    $perenimi = $kasutaja[1]
    $lowerkasutaja = $eesnimi.ToLower() + "." + $perenimi.ToLower()
    Write-Host $lowerkasutaja
    Remove-LocalUser -Name $lowerkasutaja
    Write-Host "Kasutaja $lowerkasutaja kustutatud!"
} elseif ($valik -eq 2) {
    #Write-Host "Valisid 2"
    $kasutaja = Read-Host "Sisesta kasutaja nimi"
    $lowerkasutaja = $kasutaja.ToLower()
    Remove-LocalUser -Name $lowerkasutaja
    Write-Host "Kasutaja $lowerkasutaja kustutatud!"
} elseif ($valik -eq 3) {
    Get-LocalUser
}