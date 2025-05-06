<#
    File List to Clipboard Script
    Opens a folder dialog, lists all files in the selected directory (sorted alphabetically),
    and copies the list to clipboard with a confirmation message.
#>

Add-Type -AssemblyName System.Windows.Forms

# Create and configure the folder browser dialog
$folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
$folderDialog.Description = "Select a folder to list files from"
$folderDialog.RootFolder = [System.Environment+SpecialFolder]::MyComputer

# Show the folder dialog and check if user selected a folder
if ($folderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $selectedFolder = $folderDialog.SelectedPath
    
    try {
        # Get all files in the selected folder (sorted alphabetically by name)
        $files = Get-ChildItem -LiteralPath $selectedFolder -File | 
                 Sort-Object -Property Name | 
                 Select-Object -ExpandProperty Name
        
        if ($files.Count -gt 0) {
            # Join sorted file names with newlines and copy to clipboard
            $fileList = $files -join "`r`n"
            [System.Windows.Forms.Clipboard]::SetText($fileList)
            
            # Show success message
            [System.Windows.Forms.MessageBox]::Show(
                "The list of $($files.Count) files (sorted alphabetically) has been copied to clipboard.", 
                "Success", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } else {
            # Show message if folder is empty
            [System.Windows.Forms.MessageBox]::Show(
                "The selected folder contains no files.", 
                "Information", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    }
    catch {
        # Show error message if something went wrong
        [System.Windows.Forms.MessageBox]::Show(
            "An error occurred while processing the folder: $_", 
            "Error", 
            [System.Windows.Forms.MessageBoxButtons]::OK, 
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
} else {
    # User canceled the folder selection
    [System.Windows.Forms.MessageBox]::Show(
        "No folder was selected. Operation canceled.", 
        "Information", 
        [System.Windows.Forms.MessageBoxButtons]::OK, 
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
}