# Script pour télécharger une vidéo avec yt-dlp (avec interface graphique)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Fonction pour afficher une boîte de dialogue de saisie
function Get-InputBox {
    param (
        [string]$Prompt,
        [string]$Title = 'Entrée requise',
        [string]$DefaultText = ''
    )
    
    return [Microsoft.VisualBasic.Interaction]::InputBox($Prompt, $Title, $DefaultText)
}

# Afficher une fenêtre pour entrer l'URL
$url = Get-InputBox -Prompt "Veuillez entrer l'URL de la vidéo ou de la chaine à télécharger" -Title "URL YouTube"

# Vérifier si l'URL a été fournie
if ([string]::IsNullOrWhiteSpace($url)) {
    [System.Windows.Forms.MessageBox]::Show("Aucune URL fournie. Le script va s'arrêter.", "Erreur", "OK", "Error")
    exit
}

# Boîte de dialogue pour sélectionner le dossier de destination
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Sélectionnez le dossier de destination pour le téléchargement"
$folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer

# Vérifier si l'utilisateur a sélectionné un dossier
if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $destinationFolder = $folderBrowser.SelectedPath
    
    # Créer le dossier s'il n'existe pas (au cas où)
    if (-not (Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    }
    
    # Exécuter la commande yt-dlp avec une fenêtre de progression
    $progressForm = New-Object System.Windows.Forms.Form
    $progressForm.Text = "Téléchargement en cours..."
    $progressForm.Size = New-Object System.Drawing.Size(300, 100)
    $progressForm.StartPosition = "CenterScreen"
    
    $progressLabel = New-Object System.Windows.Forms.Label
    $progressLabel.Text = "Téléchargement de la vidéo..."
    $progressLabel.Location = New-Object System.Drawing.Point(10, 20)
    $progressLabel.AutoSize = $true
    $progressForm.Controls.Add($progressLabel)
    
    $progressForm.Show()
    $progressForm.Refresh()
    
    try {
        # Exécuter yt-dlp en spécifiant explicitement le dossier de destination
        & yt-dlp --cookies youtube_cookies.txt -f "bv*+ba" -o "$destinationFolder\%(title)s.%(ext)s" $url
        
        # Vérifier si le téléchargement a réussi
        if ($LASTEXITCODE -eq 0) {
            # Ouvrir l'explorateur dans le dossier de destination
            explorer $destinationFolder
            
            [System.Windows.Forms.MessageBox]::Show("Téléchargement terminé avec succès!", "Terminé", "OK", "Information")
        } else {
            [System.Windows.Forms.MessageBox]::Show("Erreur lors du téléchargement (code de sortie: $LASTEXITCODE)", "Erreur", "OK", "Error")
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Erreur lors du téléchargement : $($_.Exception.Message)", "Erreur", "OK", "Error")
    }
    finally {
        $progressForm.Close()
    }
} else {
    [System.Windows.Forms.MessageBox]::Show("Aucun dossier sélectionné. Le script va s'arrêter.", "Annulé", "OK", "Warning")
}