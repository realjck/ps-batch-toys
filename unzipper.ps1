Add-Type -AssemblyName System.Windows.Forms

# Créer une instance de FolderBrowserDialog
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

# Afficher la boîte de dialogue de sélection de dossier
$dialogResult = $folderBrowser.ShowDialog()

# Vérifier si l'utilisateur a appuyé sur le bouton "OK"
if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
	# Récupérer le chemin du dossier sélectionné
	$selectedFolder = $folderBrowser.SelectedPath
	# dézipper les .zip
	Get-ChildItem -Path $selectedFolder -Filter "*.zip" | ForEach-Object {
		$zipFile = $_.FullName
		$zipName = $_.BaseName
		$targetPath = Join-Path $selectedFolder $zipName

		if (-Not (Test-Path $targetPath)) {
				New-Item -ItemType Directory -Path $targetPath
		}

		Expand-Archive -Path $zipFile -DestinationPath $targetPath
	}
} else {
  Write-Output "Aucun dossier sélectionné."
}

