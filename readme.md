# 🎮 7 Days to Die - Multi-Version Launcher

This script allows you to **launch multiple versions** of *7 Days to Die*, either via **Steam** or a **local executable**, while managing unique registry settings and user data folders.

---

## 🚀 Features

- ✅ Import `.reg` file for settings before launch (if present)
- ✅ Launch the game via **Steam** or direct EXE
- ✅ Use a separate `-UserDataFolder` for save/config isolation
- ✅ Wait for the game process to exit before continuing
- ✅ Export updated registry settings after game closes
- ✅ Centralized `SETUP` section for easy configuration
- ✅ Optional **silent mode** to suppress output and pauses

---

## ⚙️ Configuration (`SETUP` section)

```bat
REM === SETUP ===
set "silentMode=true"                          & REM Set to "true" for silent mode, "false" for verbose mode
set "useSteamLaunch=true"                      & REM Set to "true" to launch via Steam, "false" to run the EXE directly
set "steamAppID=251570"                        & REM Steam App ID for 7 Days to Die
set "regFileName=7d2dsettings.reg"             & REM Name of the .reg file (no path)
set "exeName=7DaysToDie.exe"                   & REM Name of the executable (used if useSteamLaunch=false)
set "regExportKey=HKEY_CURRENT_USER\Software\The Fun Pimps\7 Days To Die"  & REM Registry key to export
set "processNameToWatch=7DaysToDie.exe"        & REM The process name to monitor for exit
```

---

## 📂 Folder Structure

```
[Your Launcher Folder]/
├── 7DaysToDie.exe               (if launching locally)
├── 7d2dsettings.reg             (registry file used for config)
├── userdata/                    (created by the game with custom saves)
├── Launch7DTD.bat               (this script)
```

---