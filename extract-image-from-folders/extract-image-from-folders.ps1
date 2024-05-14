Add-Type -AssemblyName System.Windows.Forms

Write-Output "Veuillez sélectionner un dossier contenant des dossiers avec des images à extraire à la racine."
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$dialogResult = $folderBrowser.ShowDialog()
if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
	$selectedFolder = $folderBrowser.SelectedPath
	
	# Obtenir la liste des sous-dossiers dans le dossier courant
	$sousDossiers = Get-ChildItem -Path $selectedFolder -Directory

	# Parcourir chaque sous-dossier
	foreach ($dossier in $sousDossiers) {
			# Récupérer le premier fichier d'image (jpg ou png) par ordre alphabétique
			$fichierImage = Get-ChildItem -Path $dossier.FullName -Filter *.jpg -File | Sort-Object -Property Name | Select-Object -First 1

			if (-not $fichierImage) {
					$fichierImage = Get-ChildItem -Path $dossier.FullName -Filter *.png -File | Sort-Object -Property Name | Select-Object -First 1
			}

			# Vérifier si un fichier d'image a été trouvé dans le dossier
			if ($fichierImage -ne $null) {
					# Créer le chemin de destination pour le fichier d'image
					$cheminDestination = Join-Path -Path $selectedFolder -ChildPath "$($dossier.Name).$($fichierImage.Extension)"

					# Copier le fichier d'image à la racine en le renommant avec le nom du dossier d'où il provient
					Copy-Item -Path $fichierImage.FullName -Destination $cheminDestination -Force
					
					Write-Host "Fichier copié : $($fichierImage.FullName)"
			}
	}
} else {
  Write-Output "Opération annulée."
}
