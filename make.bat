@echo off

echo ***************************************************************
echo *
echo * OpenTTD "Bulgarian Town Names"
echo * Copyright (c) 2017 Rusi Dimitrov
echo * This program comes with ABSOLUTELY NO WARRANTY.
echo * This is free software, and you are welcome to redistribute it
echo * under certain conditions of GPL v3 license.
echo *
echo ***************************************************************

:: Set variables
set nmlc=%cd%\..\nmlc.exe
set tar=%cd%\utils\7z\7za.exe
set src=%cd%\src
type %src%\custom_tags-base.txt | more /p > %src%\custom_tags.txt
set /p version=<%cd%\src\custom_tags.txt
	for /f "tokens=2 delims=:" %%a in ("%version%") do set version=%%a
set name=bg_names
set build=Bulgarian_Town_Names-%version%
set release=%cd%\build\%build%

:: Create folder
echo.
echo  *** Creating folder: \build\%build%
echo.
md "%release%"

:: Building
echo.
echo  *** Building from the source, please wait...
echo.
for %%i in (%src%\%name%.nml) do %nmlc% ^
	--grf=%release%\%name%.grf ^
	--custom-tags=%src%\custom_tags.txt ^
	--lang-dir=%src%\lang ^
	%src%\%name%.nml ^
	--verbosity=4

:: Copy files
copy %cd%\docs\*.txt %release% >nul
copy %cd%\LICENSE %release%\license.txt >nul

:: Create TAR archive
echo.
echo  *** Creating archive: %release%.tar
echo.
%tar% a "%release%.tar" "%release%" >nul

:: Cleanup files and dirs
del %src%\custom_tags.txt
if exist "%release%.tar" rd /q /s "%cd%\.nmlcache\" "%release%"

:: Finish
echo.
echo ********************** Building finished **********************
echo.
echo To install copy the NewGRF archive to the OpenTTD NewGRF directory:
echo.
echo  * C:\My Documents\newgrf (Win 95, 98, ME)
echo  * C:\Documents and Settings\^<username^>\My Documents\OpenTTD\newgrf (Win 2000, XP)
echo  * C:\Users\^<username^>\Documents\OpenTTD\newgrf (Win Vista, 7, 8, 8.1, 10)
echo  * \OpenTTDPortable\Data\OpenTTD\newgrf (Portable version)

:: Pause
echo.
pause
