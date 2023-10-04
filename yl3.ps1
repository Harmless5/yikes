# Skript, mis kasutajaloomine AD-s kontrollides kas kasutaja juba on olemas

# Küsi kasutajalt ees- ja perenimi
$eesnimi = Read-Host "Sisesta oma eesnimi: "
$perenimi = Read-Host "Sisesta oma perenimi: "

# Loo nime põhjal Windowsi kasutaja
$konto = $eesnimi.ToLower() + "." + $perenimi.ToLower()

# Kontrolli kas kasutaja on juba olemas
if (Get-ADUser -Filter {SamAccountName -eq $konto}) {
    Write-Host "Kasutaja $konto on juba olemas!"
    Write-Host $Error[0].Exception.Message
    exit
} else {
    # Loome kasutaja parooliga "Parool1!"
    New-ADUser -Name $konto -SamAccountName $konto -AccountPassword (ConvertTo-SecureString -AsPlainText "Parool1!" -Force) -Enabled $true -ChangePasswordAtLogon $true
    if ($?) {
        Write-Host "Kasutaja $konto loodud!"
    } else {
        Write-Host "Kasutaja $konto loomine eba6nnestus!"
        Write-Host $Error[0].Exception.Message
        exit
    }
}