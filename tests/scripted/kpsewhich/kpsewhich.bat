@echo off
if "%RUNTYPE%"=="many-vowel" (
    for %%f in (*.dat) do echo %%f
    exit /b 0
)
if "%RUNTYPE%"=="bad-response" (
    echo.
    exit /b 0
)
