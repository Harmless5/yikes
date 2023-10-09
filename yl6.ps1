# Skript, mis kontrollib kõikide kasutajate olemasolu süsteemis ja igale kasutajale loob tema kodukataloogi varundus, mille paigutad C:\Backup kausta.

# Saame kõik kasutajad
Get-ADUser -Filter * | ForEach-Object {
    # Kontrollime, kas kasutajal on kodukataloog
    if($_.HomeDirectory) {
        # Teeme varunduse faili nime kujul kasutajanimi-kuupäev.zip
        $backupFileName = $_.SamAccountName + "-" + (Get-Date).ToString("dd.MM.yyyy") + ".zip"
        # Teeme varunduse faili täisnime kujul C:\Backup\kasutajanimi\kasutajanimi-kuupäev.zip
        $backupPath = "C:\Backup\" + $_.SamAccountName + "\" + $backupFileName
        # Teeme kasutaja kodukataloogi varunduse kausta, kui seda veel ei ole
        if(!(Test-Path "C:\Backup\" + $_.SamAccountName)) {
            New-Item -ItemType Directory -Path "C:\Backup\" + $_.SamAccountName
        }
        # Teeme varunduse
        Compress-Archive -Path $_.HomeDirectory -DestinationPath $backupPath
    }
}