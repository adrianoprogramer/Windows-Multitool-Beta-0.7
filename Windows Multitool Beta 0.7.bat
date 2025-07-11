@echo off
title silkspectre0 Optimizer vBeta 0.7 Multilang + GitHub Auth Optional
REM ===========================================================
REM silkspectre0 Optimizer Beta 0.7 – English / Español
REM © 2025 AdrianoDev / silkspectre0 — MIT License (mantén los créditos)
REM IG: @silkspectre0
REM Internet sólo requerido para GitHub Auth y Office Activation
REM ===========================================================

chcp 65001 >nul

:: Verificar integridad de créditos
findstr /C:"AdrianoDev" "%~f0" >nul || (echo ERROR: credit AdrianoDev missing. Abort.&pause&exit /b)
findstr /C:"silkspectre0" "%~f0" >nul || (echo ERROR: alias silkspectre0 missing. Abort.&pause&exit /b)

:: Proteger script contra edición inadvertida
icacls "%~f0" /inheritance:r /grant:r "%USERNAME%:F" /grant *S-1-1-0:RX >nul 2>&1

:: Selección de idioma
:LANG
cls
echo ============================================
echo   silkspectre0 Optimizer — Select Language
echo ============================================
echo 1 • English
echo 2 • Español
set /p lang=Choose (1 or 2): 
if "%lang%"=="1" set LANG=EN&goto UAC
if "%lang%"=="2" set LANG=ES&goto UAC
goto LANG

:UAC
if "%1"=="elevado" goto MENU_%LANG%
powershell -Command "Start-Process '%~f0' -ArgumentList elevado -Verb RunAs"
if errorlevel 1 (
  if "%LANG%"=="EN" echo Admin privileges required.&pause
  if "%LANG%"=="ES" echo Se requieren permisos de administrador.&pause
  exit /b
)
exit /b

:MENU_EN
cls
echo ===== Main Menu – Beta v0.7 =====
echo 1 • Beta 0.1 (Basic Tweaks)
echo 2 • Beta 0.2 (Gaming + UAC)
echo 3 • Beta 0.3 (Defender scan + SFC)
echo 4 • Beta 0.4 (Autorun + Defender off)
echo 5 • Beta 0.5 (Interactive menu)
echo 6 • Beta 0.6 (Activation & Tweaks)
echo 7 • Advanced Options (PC, Mouse, Kbd)
echo 8 • Gaming Mode Advanced
echo 9 • GitHub Login Status (optional)
echo A • Log in to GitHub (optional)
echo B • Generate README with emojis
echo C • Office Activation Tool
echo 0 • Exit
set /p opt=Select (0-C): goto HANDLE_EN_%opt%

:MENU_ES
cls
echo ===== Menú Principal – Beta v0.7 =====
echo 1 • Beta 0.1 (Ajustes básicos)
echo 2 • Beta 0.2 (Gaming + UAC)
echo 3 • Beta 0.3 (Escaneo Defender + SFC)
echo 4 • Beta 0.4 (Autorun + Defender off)
echo 5 • Beta 0.5 (Menú interactivo)
echo 6 • Beta 0.6 (Activaciones y ajustes)
echo 7 • Opciones avanzadas (PC, ratón, teclado)
echo 8 • Modo Gaming Avanzado
echo 9 • Estado GitHub Login (opcional)
echo A • Iniciar sesión en GitHub (opcional)
echo B • Generar README con emojis
echo C • Herramienta de Activación de Office
echo 0 • Salir
set /p opt=Selecciona (0-C): goto HANDLE_ES_%opt%

:: Salida
:HANDLE_EN_0 exit /b
:HANDLE_ES_0 exit /b

:: GitHub status (no obliga a internet)
:HANDLE_EN_9 gh auth status || echo Not logged in or GitHub CLI missing.&pause&goto MENU_EN
:HANDLE_ES_9 gh auth status || echo No logueado o falta GitHub CLI.&pause&goto MENU_ES

:: GitHub login (opcional; requiere internet)
:HANDLE_EN_A gh auth login&&echo Logged in!||echo Login failed.&pause&goto MENU_EN
:HANDLE_ES_A gh auth login&&echo ¡Conectado!||echo Falló el login.&pause&goto MENU_ES

:: README
:HANDLE_EN_B call :MAKE_README_EN&goto MENU_EN
:HANDLE_ES_B call :MAKE_README_ES&goto MENU_ES

:: Advanced options
:HANDLE_EN_7 call :EXTRA_EN&goto MENU_EN
:HANDLE_ES_7 call :EXTRA_ES&goto MENU_ES

:: Gaming mode advanced
:HANDLE_EN_8 call :GAMING_EN&goto MENU_EN
:HANDLE_ES_8 call :GAMING_ES&goto MENU_ES

:: Office Activation Tool
:HANDLE_EN_C call :OFFICE_ACTIVATION_EN&goto MENU_EN
:HANDLE_ES_C call :OFFICE_ACTIVATION_ES&goto MENU_ES

:: Betas 1-6
if "%opt%"=="1" call :BETA1
if "%opt%"=="2" call :BETA2
if "%opt%"=="3" call :BETA3
if "%opt%"=="4" call :BETA4
if "%opt%"=="5" call :BETA5
if "%opt%"=="6" call :BETA6
goto MENU_%LANG%

:: ===========================================================
:: ====================== FUNCIONES DE BETAS =================
:: ===========================================================

:: Beta 0.1 (Basic Tweaks)
:BETA1
if "%LANG%"=="EN" (
    echo Applying Basic Tweaks...
    echo Disabling Telemetry...
) else (
    echo Aplicando ajustes básicos...
    echo Desactivando telemetría...
)
sc config DiagTrack start= disabled >nul
sc stop DiagTrack >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
ipconfig /flushdns >nul
echo 0.0.0.0 vortex.data.microsoft.com >> "%windir%\System32\drivers\etc\hosts"
del /q /f "%TEMP%\*.*" >nul
if "%LANG%"=="EN" (
    echo Basic Tweaks applied! & pause
) else (
    echo Ajustes básicos aplicados! & pause
)
exit /b

:: Beta 0.2 (Gaming + UAC)
:BETA2
if "%LANG%"=="EN" (
    echo Optimizing for Gaming...
) else (
    echo Optimizando para Gaming...
)
powershell -Command "Stop-Process -Name dwm -Force" >nul
powercfg /setactive SCHEME_MIN >nul
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul
sc stop SysMain >nul
if "%LANG%"=="EN" (
    echo Gaming optimizations done! & pause
) else (
    echo Optimizaciones de Gaming aplicadas! & pause
)
exit /b

:: Beta 0.3 (Defender scan + SFC)
:BETA3
if "%LANG%"=="EN" (
    echo Running Defender Scan...
) else (
    echo Ejecutando escaneo Defender...
)
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2 >nul
sfc /scannow >nul
if "%LANG%"=="EN" (
    echo Scan completed! & pause
) else (
    echo Escaneo completado! & pause
)
exit /b

:: Beta 0.4 (Autorun + Defender off)
:BETA4
if "%LANG%"=="EN" (
    echo Disabling Defender and adding to startup...
) else (
    echo Desactivando Defender y añadiendo al inicio...
)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v silkspectre0_autostart /t REG_SZ /d "\"%~f0\" elevado" /f >nul
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul
if "%LANG%"=="EN" (
    echo Changes applied! & pause
) else (
    echo Cambios aplicados! & pause
)
exit /b

:: Beta 0.5 (Interactive menu)
:BETA5
set autorun=OFF
set defender=OFF
set gaming=OFF
set extras=OFF
call :INTERACTIVE
exit /b

:: Beta 0.6 (Activation & Tweaks)
:BETA6
if "%LANG%"=="EN" (
    echo Checking Windows activation...
) else (
    echo Verificando activación de Windows...
)
cscript /nologo "%windir%\system32\slmgr.vbs" /xpr
if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" (
    cscript /nologo "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /dstatus | findstr /I "LICENSE STATUS"
)
if "%LANG%"=="EN" (
    echo Activation check done! & pause
) else (
    echo Verificación completada! & pause
)
exit /b

:: ===========================================================
:: ====================== MENÚ INTERACTIVO ===================
:: ===========================================================

:INTERACTIVE
:INT_LOOP
if "%LANG%"=="EN" (
    echo ==== Interactive Menu ====
    echo 1 Autorun [%autorun%]
    echo 2 Defender OFF [%defender%]
    echo 3 Full Scan
    echo 4 Gaming Basic [%gaming%]
    echo 5 Clean DNS+Temp
    echo 6 Extras Off [%extras%]
    echo 7 Activation Check
    echo 8 Advanced Settings
    echo 9 Back
    set /p ie=Choose (1-9):
) else (
    echo ==== Menú Interactivo ====
    echo 1 Autorun [%autorun%]
    echo 2 Defender OFF [%defender%]
    echo 3 Escaneo completo
    echo 4 Gaming básico [%gaming%]
    echo 5 Limpieza DNS+Temp
    echo 6 Extras OFF [%extras%]
    echo 7 Verificar activación
    echo 8 Ajustes avanzados
    echo 9 Volver
    set /p ie=Selecciona (1-9):
)
if "%ie%"=="1" call :TOGGLE_AUTORUN&goto INT_LOOP
if "%ie%"=="2" call :TOGGLE_DEFENDER&goto INT_LOOP
if "%ie%"=="3" call :FULLSCAN&goto INT_LOOP
if "%ie%"=="4" call :TOGGLE_GAMING_BASIC&goto INT_LOOP
if "%ie%"=="5" call :CLEAN&goto INT_LOOP
if "%ie%"=="6" call :TOGGLE_EXTRAS&goto INT_LOOP
if "%ie%"=="7" call :ACTIVATE_CHECK&goto INT_LOOP
if "%ie%"=="8" call :EXTRA_EN&goto INT_LOOP
if "%ie%"=="9" exit /b
goto INT_LOOP

:: ===========================================================
:: ====================== FUNCIONES AVANZADAS ================
:: ===========================================================

:TOGGLE_GAMING_BASIC
if "%gaming%"=="ON" (
    set gaming=OFF
    if "%LANG%"=="EN" (
        echo Gaming Basic OFF & pause
    ) else (
        echo Gaming básico DESACTIVADO & pause
    )
) else (
    powershell -Command "Stop-Process -Name dwm -Force" >nul
    sc stop SysMain >nul
    powercfg /setactive SCHEME_MIN >nul
    set gaming=ON
    if "%LANG%"=="EN" (
        echo Gaming Basic ON & pause
    ) else (
        echo Gaming básico ACTIVADO & pause
    )
)
exit /b

:GAMING_EN
echo Applying Advanced Gaming Tweaks...
powershell -Command "Stop-Process -Name dwm -Force" >nul
sc stop SysMain >nul
sc config SysMain start=disabled >nul
powercfg /setactive SCHEME_MIN >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d ffffffff /f >nul
echo Advanced Gaming tweaks applied. & pause
exit /b
:GAMING_ES goto GAMING_EN

:EXTRA_EN
cls
if "%LANG%"=="EN" (
    echo Advanced Settings:
    echo 1 Rename PC
    echo 2 Mouse sensitivity
    echo 3 Keyboard repeat
    echo 0 Back
    set /p e=Choose (0-3):
) else (
    echo Ajustes avanzados:
    echo 1 Cambiar nombre del PC
    echo 2 Sensibilidad del ratón
    echo 3 Repetición del teclado
    echo 0 Volver
    set /p e=Elige (0-3):
)
if "%e%"=="1" goto RENAME_PC
if "%e%"=="2" goto ADJ_MOUSE
if "%e%"=="3" goto ADJ_KBD
if "%e%"=="0" exit /b
goto EXTRA_EN

:RENAME_PC
set /p newnm=Enter new PC name: 
wmic computersystem where name^="%computername%" rename name="%newnm%"
if "%LANG%"=="EN" echo Renamed to %newnm%. Restart to apply.
if "%LANG%"=="ES" echo Cambiado a %newnm%. Reinicia para aplicar.
pause & exit /b

:ADJ_MOUSE
set /p ms=Sensitivity (1-20): 
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d "%ms%" /f
powershell -C "Add-Type -Name U32 -Namespace M -MemberDefinition @'[DllImport(\"user32.dll\")] public static extern bool SystemParametersInfo(uint uiA,uint uiP,uint pv,uint f); '@; [M.U32]::SystemParametersInfo(0x0071,0,%ms%,0)" >nul
if "%LANG%"=="EN" echo Mouse sensitivity set to %ms%.
if "%LANG%"=="ES" echo Sensibilidad del ratón ajustada a %ms%.
pause & exit /b

:ADJ_KBD
set /p ard=Delay (ms): 
set /p arr=Rate (1-30): 
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v AutoRepeatDelay /t REG_SZ /d "%ard%" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v AutoRepeatRate /t REG_SZ /d "%arr%" /f
if "%LANG%"=="EN" echo Keyboard adjusted.
if "%LANG%"=="ES" echo Teclado ajustado.
pause & exit /b

:FULLSCAN
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
sfc /scannow
if "%LANG%"=="EN" echo Scan complete.
if "%LANG%"=="ES" echo Escaneo completado.
pause & exit /b

:CLEAN
ipconfig /flushdns
del /q /f "%TEMP%\*.*" >nul
del /q /f "%SystemRoot%\Temp\*.*" >nul
if "%LANG%"=="EN" echo Clean done.
if "%LANG%"=="ES" echo Limpieza completada.
pause & exit /b

:TOGGLE_EXTRAS
if "%extras%"=="ON" (
    set extras=OFF
    if "%LANG%"=="EN" echo Extras OFF.
    if "%LANG%"=="ES" echo Extras DESACTIVADOS.
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f
    set extras=ON
    if "%LANG%"=="EN" echo Extras ON.
    if "%LANG%"=="ES" echo Extras ACTIVADOS.
)
pause & exit /b

:ACTIVATE_CHECK
cscript /nologo "%windir%\system32\slmgr.vbs" /xpr
if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" (
    cscript /nologo "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /dstatus | findstr /I "LICENSE STATUS"
)
pause & exit /b

:: ===========================================================
:: ================== OFFICE ACTIVATION TOOL ==================
:: ===========================================================

:OFFICE_ACTIVATION_EN
cls
echo ===== Office Activation Tool =====
echo 1. Activate Office with Ohook
echo 2. Uninstall Ohook
echo 3. Check activation status
echo 0. Back to main menu
echo.
set /p office_opt=Select option (0-3): 

if "%office_opt%"=="1" call :ACTIVATE_OFFICE
if "%office_opt%"=="2" call :UNINSTALL_OHOOK
if "%office_opt%"=="3" call :CHECK_ACTIVATION_STATUS
if "%office_opt%"=="0" goto MENU_EN
goto OFFICE_ACTIVATION_EN

:OFFICE_ACTIVATION_ES
cls
echo ===== Herramienta de Activación de Office =====
echo 1. Activar Office con Ohook
echo 2. Desinstalar Ohook
echo 3. Verificar estado de activación
echo 0. Volver al menú principal
echo.
set /p office_opt=Seleccione opción (0-3): 

if "%office_opt%"=="1" call :ACTIVATE_OFFICE
if "%office_opt%"=="2" call :UNINSTALL_OHOOK
if "%office_opt%"=="3" call :CHECK_ACTIVATION_STATUS
if "%office_opt%"=="0" goto MENU_ES
goto OFFICE_ACTIVATION_ES

:ACTIVATE_OFFICE
setlocal
set "tempDir=%TEMP%\Ohook_Office_Activator"
set "resourcesUrl=https://github.com/massgravel/Microsoft-Activation-Scripts/raw/master/Ohook/Resources.zip"

if not exist "%tempDir%" mkdir "%tempDir%"

if not exist "%tempDir%\sppc64.dll" (
    if "%LANG%"=="EN" echo Downloading required files...
    if "%LANG%"=="ES" echo Descargando archivos necesarios...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%resourcesUrl%', '%tempDir%\Resources.zip')" || (
        if "%LANG%"=="EN" echo Download failed.
        if "%LANG%"=="ES" echo Error en la descarga.
        endlocal
        exit /b 1
    )
    powershell -Command "Expand-Archive -Path '%tempDir%\Resources.zip' -DestinationPath '%tempDir%' -Force" || (
        if "%LANG%"=="EN" echo Extraction failed.
        if "%LANG%"=="ES" echo Error al extraer.
        endlocal
        exit /b 1
    )
    del "%tempDir%\Resources.zip" >nul 2>&1
)

if "%LANG%"=="EN" echo Stopping Office services...
if "%LANG%"=="ES" echo Deteniendo servicios de Office...
net stop sppsvc >nul 2>&1
taskkill /f /im OfficeClickToRun.exe >nul 2>&1
taskkill /f /im WINWORD.EXE >nul 2>&1
taskkill /f /im EXCEL.EXE >nul 2>&1

set "officeFound=0"
set "officePath="
set "officeArch="

for %%v in (16.0) do (
    reg query "HKLM\SOFTWARE\Microsoft\Office\%%v\Common\InstallRoot" >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=2*" %%a in (
            'reg query "HKLM\SOFTWARE\Microsoft\Office\%%v\Common\InstallRoot" /v "Path"'
        ) do (
            set "officePath=%%b"
            set "officeFound=1"
        )
    )
)

if not defined officePath (
    if "%LANG%"=="EN" echo Office installation not found.
    if "%LANG%"=="ES" echo No se encontró Office instalado.
    endlocal
    exit /b 1
)

if exist "%officePath%\Office16\OSPP.VBS" (
    set "officeArch=x64"
    set "targetDll=sppc64.dll"
) else (
    set "officeArch=x86"
    set "targetDll=sppc32.dll"
)

if exist "%officePath%\%targetDll%" (
    copy /y "%officePath%\%targetDll%" "%tempDir%\%targetDll%.bak" >nul 2>&1 || (
        if "%LANG%"=="EN" echo Failed to backup original file.
        if "%LANG%"=="ES" echo Error al respaldar archivo original.
        endlocal
        exit /b 1
    )
)

takeown /f "%officePath%\%targetDll%" >nul 2>&1
icacls "%officePath%\%targetDll%" /grant Administrators:F >nul 2>&1
copy /y "%tempDir%\%targetDll%" "%officePath%\%targetDll%" >nul 2>&1 || (
    if "%LANG%"=="EN" echo Failed to apply Ohook.
    if "%LANG%"=="ES" echo Error al aplicar Ohook.
    endlocal
    exit /b 1
)

reg delete "HKLM\SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\Common\Licensing\Resiliency" /f >nul 2>&1

net start sppsvc >nul 2>&1

if "%LANG%"=="EN" echo Office activation completed successfully!
if "%LANG%"=="ES" echo ¡Activación de Office completada con éxito!
pause
endlocal
exit /b 0

:UNINSTALL_OHOOK
setlocal
set "tempDir=%TEMP%\Ohook_Office_Activator"

if "%LANG%"=="EN" echo Stopping Office services...
if "%LANG%"=="ES" echo Deteniendo servicios de Office...
net stop sppsvc >nul 2>&1
taskkill /f /im OfficeClickToRun.exe >nul 2>&1
taskkill /f /im WINWORD.EXE >nul 2>&1
taskkill /f /im EXCEL.EXE >nul 2>&1

set "officeFound=0"
set "officePath="
set "officeArch="

for %%v in (16.0) do (
    reg query "HKLM\SOFTWARE\Microsoft\Office\%%v\Common\InstallRoot" >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=2*" %%a in (
            'reg query "HKLM\SOFTWARE\Microsoft\Office\%%v\Common\InstallRoot" /v "Path"'
        ) do (
            set "officePath=%%b"
            set "officeFound=1"
        )
    )
)

if not defined officePath (
    if "%LANG%"=="EN" echo Office installation not found.
    if "%LANG%"=="ES" echo No se encontró Office instalado.
    endlocal
    exit /b 1
)

if exist "%officePath%\Office16\OSPP.VBS" (
    set "officeArch=x64"
    set "targetDll=sppc64.dll"
) else (
    set "officeArch=x86"
    set "targetDll=sppc32.dll"
)

if exist "%tempDir%\%targetDll%.bak" (
    takeown /f "%officePath%\%targetDll%" >nul 2>&1
    icacls "%officePath%\%targetDll%" /grant Administrators:F >nul 2>&1
    move /y "%tempDir%\%targetDll%.bak" "%officePath%\%targetDll%" >nul 2>&1 || (
        if "%LANG%"=="EN" echo Failed to restore original file.
        if "%LANG%"=="ES" echo Error al restaurar archivo original.
        endlocal
        exit /b 1
    )
)

reg delete "HKLM\SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\Common\Licensing\Resiliency" /f >nul 2>&1

net start sppsvc >nul 2>&1

if "%LANG%"=="EN" echo Ohook has been successfully uninstalled!
if "%LANG%"=="ES" echo ¡Ohook se ha desinstalado correctamente!
pause
endlocal
exit /b 0

:CHECK_ACTIVATION_STATUS
if exist "%ProgramFiles%\Microsoft Office\Office16\OSPP.VBS" (
    cscript //nologo "%ProgramFiles%\Microsoft Office\Office16\OSPP.VBS" /dstatus
) else (
    if "%LANG%"=="EN" echo Office not found or not installed.
    if "%LANG%"=="ES" echo Office no encontrado o no instalado.
)
pause
exit /b 0

:: ===========================================================
:: ====================== GENERAR README ======================
:: ===========================================================

:MAKE_README_EN
(
echo ✅ silkspectre0 Optimizer Beta 0.7 Multilingual
echo Author: AdrianoDev (alias silkspectre0)
echo Licensed under MIT — keep credits
echo GitHub login optional via gh CLI
echo Instagram: @silkspectre0
echo.
echo Usage:
echo • Run as administrator
echo • Choose language
echo • Internet only needed for GitHub options (9/A) and Office activation (C)
echo ⚠️ Create a restore point before use
echo.
echo New in v0.7:
echo • Added Office activation tool (option C)
echo.
echo Thanks for your support! ❤️
)>"%~dp0README.txt"
if "%LANG%"=="EN" echo README generated! & pause
if "%LANG%"=="ES" echo ¡README generado! & pause
exit /b

:MAKE_README_ES
(
echo ✅ silkspectre0 Optimizer Beta 0.7 Multilingüe
echo Autor: AdrianoDev (alias silkspectre0)
echo Licencia MIT — conserva créditos
echo Login GitHub opcional con gh CLI
echo Instagram: @silkspectre0
echo.
echo Uso:
echo • Ejecuta como administrador
echo • Elige idioma
echo • Internet sólo para opciones GitHub (9/A) y activación Office (C)
echo ⚠️ Haz punto de restauración antes de usar
echo.
echo Nuevo en v0.7:
echo • Añadida herramienta de activación de Office (opción C)
echo.
echo ¡Gracias por tu apoyo! ❤️
)>"%~dp0README.txt"
if "%LANG%"=="EN" echo README generated! & pause
if "%LANG%"=="ES" echo ¡README generado! & pause
exit /b
