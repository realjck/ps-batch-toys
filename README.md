# ps-batch-toys

**Utility scripts in Powershell**

This directory contains some utilities which process batches of files. These programs were created with generative AI, requiring relatively few fixes. To compile the scripts into executables, please first install [PS2EXE](https://github.com/MScholtes/PS2EXE), and then run the build.ps1 script at the root.

```PowerShell
# Build executables
.\build.ps1
```

## download-clipboard.exe

Downloads a list of links previously copied to the clipboard

## extract-image-from-folders.exe

Copy the first image of each folder to the root by renaming it with the name of the folder

## unzipper.exe

Unzip all archives in a folder into their respective subfolders
