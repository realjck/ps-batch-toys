# Build .exe in ./dist/
# ---------------------

ps2exe -inputFile '.\scripts\download-clipboard\download-clipboard.ps1' -outputFile '.\dist\download-clipboard.exe' -x64 -iconFile '.\scripts\download-clipboard\download-clipboard.ico' -title 'download-clipboard' -description 'download-clipboard' -company 'devjck' -product 'download-clipboard' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\unzipper\unzipper.ps1' -outputFile '.\dist\unzipper.exe' -x64 -iconFile '.\scripts\unzipper\unzipper.ico' -title 'unzipper' -description 'unzipper' -company 'devjck' -product 'unzipper' -copyright 'devjck' -version '0.1.0' -longPaths -configFile

ps2exe -inputFile '.\scripts\extract-image-from-folders\extract-image-from-folders.ps1' -outputFile '.\dist\extract-image-from-folders.exe' -x64 -iconFile '.\scripts\extract-image-from-folders\extract-image-from-folders.ico' -title 'extract-image-from-folders' -description 'extract-image-from-folders' -company 'devjck' -product 'extract-image-from-folders' -copyright 'devjck' -version '0.1.0' -longPaths -configFile


## template

# ps2exe -inputFile '.\scripts\________\________.ps1' -outputFile '.\dist\________.exe' -x64 -iconFile '.\scripts\________\________.ico' -title '________' -description '________' -company 'devjck' -product '________' -copyright 'devjck' -version '0.1.0' -longPaths -configFile