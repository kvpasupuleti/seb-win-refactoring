@echo off
REM Copy Runtime and Client dependencies to Launcher output folder
REM This script is called by the post-build event

SET SOURCE_RUNTIME=%1
SET SOURCE_CLIENT=%2
SET TARGET=%3

IF EXIST "%SOURCE_RUNTIME%" (
    robocopy "%SOURCE_RUNTIME%" "%TARGET%" /E /NP /NJH /NJS /NDL /NC /NS
    IF %ERRORLEVEL% LSS 8 SET ERRORLEVEL=0
)

IF EXIST "%SOURCE_CLIENT%" (
    robocopy "%SOURCE_CLIENT%" "%TARGET%" /E /NP /NJH /NJS /NDL /NC /NS
    IF %ERRORLEVEL% LSS 8 SET ERRORLEVEL=0
)

EXIT 0

