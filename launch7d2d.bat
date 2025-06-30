@echo off
setlocal

REM === SETUP ===
set "silentMode=true"                          & REM Set to "true" for silent mode, "false" for verbose mode
set "useSteamLaunch=true"                      & REM Set to "true" to launch via Steam, "false" to run the EXE directly
set "steamAppID=251570"                        & REM Steam App ID for 7 Days to Die
set "regFileName=7d2dsettings.reg"             & REM Name of the .reg file (no path)
set "exeName=7DaysToDie.exe"                   & REM Name of the executable (used if useSteamLaunch=false)
set "regExportKey=HKEY_CURRENT_USER\Software\The Fun Pimps\7 Days To Die"  & REM Registry key to export
set "processNameToWatch=7DaysToDie.exe"        & REM The process name to monitor for exit

REM === RESOLVE PATHS ===
set "scriptdir=%~dp0"
set "userDataFolder=UserData"
set "regfile=%scriptdir%%regFileName%"
set "exefile=%scriptdir%%exeName%"

REM === SET EXECUTABLE ARGUMENTS ===
set "exeArgs=-UserDataFolder=%userDataFolder%"

REM === IMPORT REGISTRY IF FILE EXISTS ===
if exist "%regfile%" (
    if /i not "%silentMode%"=="true" echo Importing registry from %regfile%
    reg import "%regfile%" >nul 2>&1
    if %errorlevel% neq 0 (
        echo Failed to import registry file.
        if /i not "%silentMode%"=="true" pause
        exit /b %errorlevel%
    )
) else (
    if /i not "%silentMode%"=="true" echo Registry file not found. Skipping import.
)

REM === START EXECUTABLE OR STEAM ===
if /i "%useSteamLaunch%"=="true" (
    if /i not "%silentMode%"=="true" echo Launching via Steam...
    start "" "steam://rungameid/%steamAppID%" %exeArgs%
) else (
    if /i not "%silentMode%"=="true" echo Launching executable: %exeName% %exeArgs%
    start "" "%exefile%" %exeArgs%
)

REM === DELAY TO ALLOW PROCESS TO START ===
if /i not "%silentMode%"=="true" echo Waiting 10 seconds for process to initialize...
timeout /t 15 >nul

REM === WAIT FOR PROCESS TO EXIT ===
:waitForProcess
tasklist /fi "imagename eq %processNameToWatch%" | find /i "%processNameToWatch%" >nul
if not errorlevel 1 (
    if /i not "%silentMode%"=="true" echo Waiting for %processNameToWatch% to close...
    timeout /t 2 >nul
    goto waitForProcess
)

REM === EXTRA WAIT AFTER PROCESS EXIT ===
if /i not "%silentMode%"=="true" echo Process closed. Waiting briefly for cleanup...
timeout /t 3 >nul

REM === EXPORT REGISTRY AFTER EXECUTABLE ===
reg export "%regExportKey%" "%regfile%" /y >nul 2>&1
if %errorlevel% neq 0 (
    echo Failed to export registry.
    if /i not "%silentMode%"=="true" pause
    exit /b %errorlevel%
)

if /i not "%silentMode%"=="true" (
    echo Registry updated and saved to %regfile%.
    pause
)

endlocal