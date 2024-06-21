Add-Type -AssemblyName System.Windows.Forms

Write-Output "Please select a folder containing archives to unzip."

# Create a FolderBrowserDialog instance
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$dialogResult = $folderBrowser.ShowDialog()

# Check if "OK"
if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
	# Get path
	$selectedFolder = $folderBrowser.SelectedPath
	
	Write-Output "Please select the destination folder."
	
	$dialogResult = $folderBrowser.ShowDialog()
	
	if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
		
		$selectedTargetFolder = $folderBrowser.SelectedPath
	
		# Unzip
		Get-ChildItem -Path $selectedFolder -Filter "*.zip" | ForEach-Object {
			$zipFile = $_.FullName
			$zipName = $_.BaseName
			$targetPath = Join-Path $selectedTargetFolder $zipName

			if (-Not (Test-Path $targetPath)) {
					New-Item -ItemType Directory -Path $targetPath
			}

			Expand-Archive -Path $zipFile -DestinationPath $targetPath
		}
		
	} else {
		Write-Output "Operation canceled."
	}
} else {
  Write-Output "Operation canceled."
}

