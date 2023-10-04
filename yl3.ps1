# Skript, mis kasutajaloomine AD-s kontrollides kas kasutaja juba on olemas

# Nimekiri inimestest
$inimesed = @(Kristjan Kirsipuu, Kalle Kukk, Malle Mänd, Kätlin Kask)

# Loo nime põhjal Windowsi kasutaja
$konto = $inimesed[0].ToLower() + "." + $inimesed[1].ToLower()

# Kontrolli kas kasutaja on juba olemas
if (Get-ADUser -Filter {SamAccountName -eq $konto}) {
    Write-Host "Kasutaja $konto on juba olemas!"
    Write-Host $Error[0].Exception.Message
    exit
} else {
    # Loome kasutaja parooliga "Parool1!"
    New-ADUser -Name $konto -AccountPassword (ConvertTo-SecureString -AsPlainText "Parool1!" -Force)
    if ($?) {
        Write-Host "Kasutaja $konto loodud!"
    } else {
        Write-Host "Kasutaja $konto loomine eba6nnestus!"
        Write-Host $Error[0].Exception.Message
        exit
    }
}