for %%i in (.\src\*.nml) do nmlc.exe %%~i --grf=%%~ni.grf -l .\src\lang
md "build"
for %%i in (*.grf) do move "%~dp0\%%i" "build"
rd /q /s "%~dp0\.nmlcache\"
pause
