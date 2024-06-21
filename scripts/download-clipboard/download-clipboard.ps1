Add-Type -AssemblyName System.Windows.Forms

function Select-FolderDialog {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialogResult = $folderBrowser.ShowDialog()
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    }
    return $null
}
Write-Output "Please select a folder to download the URL files contained in the clipboard."
# Open a dialog window to select the destination folder
$destinationFolder = Select-FolderDialog

if ([string]::IsNullOrWhiteSpace($destinationFolder)) {
    Write-Host "No folder selected. The script will stop."
    exit
}

# Check if the folder exists, if not create it
if (-Not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Read URLs from clipboard
$clipboardContent = Get-Clipboard -Raw

# Separate lines
$urls = $clipboardContent -split "`r`n"

# Download each file
foreach ($url in $urls) {
    if ($url -ne '') {
        try {
            $fileName = [System.IO.Path]::GetFileName($url)
            $filePath = Join-Path -Path $destinationFolder -ChildPath $fileName
            Invoke-WebRequest -Uri $url -OutFile $filePath
            Write-Host "Downloaded: $url" -ForegroundColor Green
        } catch {
            Write-Host "**ERROR** : $url`n$_"
        }
    }
}
