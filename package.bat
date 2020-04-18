powershell Compress-Archive -Path .\* ld46.zip
move ld46.zip pkg\ld46.love
copy /b pkg\win32\love.exe+pkg\ld46.love pkg\win32\ld46.exe
copy /b pkg\win64\love.exe+pkg\ld46.love pkg\win64\ld46.exe
.\pkg\win64\ld46.exe