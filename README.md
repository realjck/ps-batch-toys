# ps-batch-toys

**Utility scripts in Powershell**

This directory contains some utilities for Windows which process batch tasks. To compile the scripts into executables, please first install [PS2EXE](https://github.com/MScholtes/PS2EXE), and then run the build.ps1 script at the root.

```PowerShell
# Build executables
.\build.ps1
```

## download-clipboard.exe

Downloads a list of links previously copied to the clipboard

## extract-image-from-folders.exe

Copy the first image of each folder to the root by renaming it with the name of the folder

## list-files-to-clipboard.exe

Copy list of files in a directory to clipboard

## url-monitoring.exe

Checks URLs from a text file, tests their connectivity, and displays colored status results and server errors

## unzipper.exe

Unzip all archives .zip and .7z in a folder into their respective subfolders

## youtube-downloader.exe

Ask for a URL and select a folder where you want to download the video or the entire channel (needs [yt-dlp](https://github.com/yt-dlp/yt-dlp))