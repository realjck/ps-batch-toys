Add-Type -AssemblyName System.Windows.Forms

# Vérifier si le module 7Zip4Powershell est installé, sinon l'installer
if (-not (Get-Module -ListAvailable -Name 7Zip4Powershell)) {
    Write-Output "Le module 7Zip4Powershell est requis. Installation en cours..."
    Install-Module -Name 7Zip4Powershell -Force -Scope CurrentUser
    Import-Module 7Zip4Powershell
}

Write-Output "Veuillez sélectionner un dossier contenant des archives à extraire."

# Créer une instance de FolderBrowserDialog
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$dialogResult = $folderBrowser.ShowDialog()

# Vérifier si "OK" a été cliqué
if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
    # Obtenir le chemin
    $selectedFolder = $folderBrowser.SelectedPath
    
    Write-Output "Veuillez sélectionner le dossier de destination."
    
    $dialogResult = $folderBrowser.ShowDialog()
    
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        
        $selectedTargetFolder = $folderBrowser.SelectedPath
    
        # Extraire les fichiers .zip
        Get-ChildItem -Path $selectedFolder -Filter "*.zip" | ForEach-Object {
            $zipFile = $_.FullName
            $zipName = $_.BaseName
            $targetPath = Join-Path $selectedTargetFolder $zipName

            if (-Not (Test-Path $targetPath)) {
                    New-Item -ItemType Directory -Path $targetPath
            }

            Expand-Archive -Path $zipFile -DestinationPath $targetPath
        }
        
        # Extraire les fichiers .7z
        Get-ChildItem -Path $selectedFolder -Filter "*.7z" | ForEach-Object {
            $sevenZipFile = $_.FullName
            $sevenZipName = $_.BaseName
            $targetPath = Join-Path $selectedTargetFolder $sevenZipName

            if (-Not (Test-Path $targetPath)) {
                    New-Item -ItemType Directory -Path $targetPath
            }

            Expand-7Zip -ArchiveFileName $sevenZipFile -TargetPath $targetPath
        }
        
        Write-Output "Extraction terminée."
    } else {
        Write-Output "Opération annulée."
    }
} else {
    Write-Output "Opération annulée."
}