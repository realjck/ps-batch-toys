Add-Type -AssemblyName System.Windows.Forms

function Select-FolderDialog {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialogResult = $folderBrowser.ShowDialog()
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    }
    return $null
}

# Ouvrir une fenêtre de dialogue pour sélectionner le dossier de destination
$destinationFolder = Select-FolderDialog

if ([string]::IsNullOrWhiteSpace($destinationFolder)) {
    Write-Host "Aucun dossier sélectionné. Le script va s'arrêter."
    exit
}

# Vérifier si le dossier existe, sinon le créer
if (-Not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Lire les URLs depuis le presse-papiers
$clipboardContent = Get-Clipboard -Raw

# Séparer le contenu du presse-papiers en lignes individuelles
$urls = $clipboardContent -split "`r`n"

# Télécharger chaque fichier à partir des URLs
foreach ($url in $urls) {
    if ($url -ne '') {
        try {
            # Obtenir le nom du fichier à partir de l'URL
            $fileName = [System.IO.Path]::GetFileName($url)
            
            # Télécharger le fichier
            $filePath = Join-Path -Path $destinationFolder -ChildPath $fileName
            Invoke-WebRequest -Uri $url -OutFile $filePath
            Write-Host "Téléchargé : $url" -ForegroundColor Green
        } catch {
            Write-Host "Erreur lors du téléchargement de : $url`n$_"
        }
    }
}
