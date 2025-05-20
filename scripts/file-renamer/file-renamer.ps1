Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Sélection du fichier texte ---
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Title = "Sélectionner le fichier texte avec la liste des noms"
$openFileDialog.Filter = "Fichiers texte (*.txt)|*.txt"
$openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")

if ($openFileDialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "Opération annulée."
    exit
}
$listePath = $openFileDialog.FileName

# --- Lecture des noms (sans remplacer les crochets) ---
$noms = Get-Content $listePath | Where-Object { $_.Trim() -ne "" } | ForEach-Object {
    # On ne remplace QUE les caractères vraiment interdits dans les noms de fichiers Windows
    $_.Trim() -replace '[\\/:*?"<>|]', '_'  # Les crochets [] sont conservés
}

# --- Sélection du dossier ---
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Sélectionnez le dossier contenant les fichiers à renommer"
$folderBrowser.RootFolder = "MyComputer"
$folderBrowser.SelectedPath = [Environment]::GetFolderPath("Desktop")

if ($folderBrowser.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "Opération annulée."
    exit
}
$dossier = $folderBrowser.SelectedPath

# --- Récupération des fichiers ---
$fichiers = Get-ChildItem -Path $dossier -File | Sort-Object Name

# --- Vérification du nombre d'éléments ---
if ($fichiers.Count -ne $noms.Count) {
    [System.Windows.Forms.MessageBox]::Show(
        "Erreur : $($fichiers.Count) fichiers trouvés, mais $($noms.Count) noms dans la liste.",
        "Erreur de correspondance",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    exit
}

# --- Renommage (avec gestion sécurisée des crochets) ---
for ($i = 0; $i -lt $fichiers.Count; $i++) {
    $fichier = $fichiers[$i]
    $nouveauNom = $noms[$i] + $fichier.Extension
    $nouveauChemin = Join-Path -Path $dossier -ChildPath $nouveauNom

    if (Test-Path -LiteralPath $nouveauChemin) {
        Write-Warning "Le fichier '$nouveauNom' existe déjà. Il ne sera pas remplacé."
        continue
    }

    try {
        # Méthode robuste pour renommer avec caractères spéciaux
        Rename-Item -LiteralPath $fichier.FullName -NewName $nouveauNom -ErrorAction Stop
        Write-Host "Renommé : $($fichier.Name) → $nouveauNom"
    }
    catch {
        Write-Warning "Échec du renommage de '$($fichier.Name)' : $_"
    }
}

[System.Windows.Forms.MessageBox]::Show(
    "Opération terminée. Vérifiez les éventuels avertissements.",
    "Statut",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
)