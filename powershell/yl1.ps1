# Skript, mis loob Windowsi kasutaja nimega "eesnimi.perenimi" ja parooliga "Parool1!"
# Küsi kasutajalt ees- ja perenimi
$eesnimi = Read-Host "Sisesta oma eesnimi: "
$perenimi = Read-Host "Sisesta oma perenimi: "

# Loo nime põhjal Windowsi kasutaja
$konto = $eesnimi.ToLower() + "." + $perenimi.ToLower()

if (Test-Path "C:\Users\$konto") {
    Write-Host "Kasutaja $konto on juba olemas!"
    Write-Host $Error[0].Exception.Message
    exit
} else {
    # Loome kasutaja parooliga "Parool1!"
    New-LocalUser -Name $konto -Password (ConvertTo-SecureString -AsPlainText "Parool1!" -Force)
    if ($?) {
        Write-Host "Kasutaja $konto loodud!"
    } else {
        Write-Host "Kasutaja $konto loomine eba6nnestus!"
        Write-Host $Error[0].Exception.Message
        exit
    }
}