# Skript, mis kontrollib kõikide kasutajate olemasolu süsteemis ja igale kasutajale loob tema kodukataloogi varundus, mille paigutad C:\Backup kausta.

# Get all AD users and loop through them
Get-ADUser -Filter * | ForEach-Object {
    # Check if user has a home directory
    if($_.HomeDirectory) {
        # Create backup filename with format username-DD.MM.YYYY.zip
        $backupFileName = $_.SamAccountName + "-" + (Get-Date).ToString("dd.MM.yyyy") + ".zip"
        # Create backup path with format C:\Backup\username\backupFileName
        $backupPath = "C:\Backup\" + $_.SamAccountName + "\" + $backupFileName
        # Create user's backup directory if it doesn't exist
        if(!(Test-Path "C:\Backup\" + $_.SamAccountName)) {
            New-Item -ItemType Directory -Path "C:\Backup\" + $_.SamAccountName
        }
        # Compress user's home directory to backup path
        Compress-Archive -Path $_.HomeDirectory -DestinationPath $backupPath
    }
}