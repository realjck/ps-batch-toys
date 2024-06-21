Add-Type -AssemblyName System.Windows.Forms

Write-Output "Please select a folder containing folders with images to extract to the root."
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$dialogResult = $folderBrowser.ShowDialog()
if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
	$selectedFolder = $folderBrowser.SelectedPath
	
	# Get the list of subfolders in the current folder
	$sousDossiers = Get-ChildItem -Path $selectedFolder -Directory

	# Browse each subfolder
	foreach ($dossier in $sousDossiers) {
      # Get first .jpg image in alphabetical order
			$fichierImage = Get-ChildItem -Path $dossier.FullName -Filter *.jpg -File | Sort-Object -Property Name | Select-Object -First 1

			if (-not $fichierImage) {
					$fichierImage = Get-ChildItem -Path $dossier.FullName -Filter *.png -File | Sort-Object -Property Name | Select-Object -First 1
			}

			# Check if image found
			if ($fichierImage -ne $null) {
					# Create destination folder
					$cheminDestination = Join-Path -Path $selectedFolder -ChildPath "$($dossier.Name).$($fichierImage.Extension)"

					# Copy image
					Copy-Item -Path $fichierImage.FullName -Destination $cheminDestination -Force
					
					Write-Host "File copied : $($fichierImage.FullName)"
			}
	}
} else {
  Write-Output "Operation cancelled."
}
