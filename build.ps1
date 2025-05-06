# Build .exe in ./dist/
# ---------------------

ps2exe -inputFile '.\scripts\download-clipboard\download-clipboard.ps1' -outputFile '.\dist\download-clipboard.exe' -x64 -iconFile '.\scripts\download-clipboard\download-clipboard.ico' -title 'download-clipboard' -description 'download-clipboard' -company 'devjck' -product 'download-clipboard' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\unzipper\unzipper.ps1' -outputFile '.\dist\unzipper.exe' -x64 -iconFile '.\scripts\unzipper\unzipper.ico' -title 'unzipper' -description 'unzipper' -company 'devjck' -product 'unzipper' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\extract-image-from-folders\extract-image-from-folders.ps1' -outputFile '.\dist\extract-image-from-folders.exe' -x64 -iconFile '.\scripts\extract-image-from-folders\extract-image-from-folders.ico' -title 'extract-image-from-folders' -description 'extract-image-from-folders' -company 'devjck' -product 'extract-image-from-folders' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\youtube-downloader\youtube-downloader.ps1' -outputFile '.\dist\youtube-downloader.exe' -x64 -iconFile '.\scripts\youtube-downloader\youtube-downloader.ico' -title 'youtube-downloader' -description 'youtube-downloader' -company 'devjck' -product 'youtube-downloader' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\url-monitoring\url-monitoring.ps1' -outputFile '.\dist\url-monitoring.exe' -x64 -iconFile '.\scripts\url-monitoring\url-monitoring.ico' -title 'url-monitoring' -description 'url-monitoring' -company 'devjck' -product 'url-monitoring' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\list-files-to-clipboard\list-files-to-clipboard.ps1' -outputFile '.\dist\list-files-to-clipboard.exe' -x64 -iconFile '.\scripts\list-files-to-clipboard\list-files-to-clipboard.ico' -title 'list-files-to-clipboard' -description 'list-files-to-clipboard' -company 'devjck' -product 'list-files-to-clipboard' -copyright 'devjck' -version '0.1.0' -longPaths -configFile -noConsole

## TEMPLATES
## ---------

# with console:
## -----------
# ps2exe -inputFile '.\scripts\________\________.ps1' -outputFile '.\dist\________.exe' -x64 -iconFile '.\scripts\________\________.ico' -title '________' -description '________' -company 'devjck' -product '________' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

# without console:
# ---------------
# ps2exe -inputFile '.\scripts\________\________.ps1' -outputFile '.\dist\________.exe' -x64 -iconFile '.\scripts\________\________.ico' -title '________' -description '________' -company 'devjck' -product '________' -copyright 'devjck' -version '0.1.0' -longPaths -configFile -noConsole