@set TMP_PATH=%1;%PATH%;
@setlocal EnableExtensions EnableDelayedExpansion
@set _PATH_=
@for %%a in ("%TMP_PATH:;=" "%") do @if not "%%~a" == "" (
    @if "!_PATH_!" == "" @set "_PATH_=;%%~a;"
    @set "_T_=!_PATH_:;%%~a;=x!"
    @if "!_T_!" == "!_PATH_!" @set "_PATH_=!_PATH_!%%~a;"
)
@endlocal && @set "TMP_PATH=%_PATH_:~1,-1%
@net session >nul 2>&1
@if %errorLevel% == 0 (
    @reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v PATH /t REG_EXPAND_SZ /d "%TMP_PATH%"
)
@reg add "HKEY_CURRENT_USER\Environment" /f /v PATH /t REG_EXPAND_SZ /d "%TMP_PATH%"
@set PATH=%TMP_PATH%
@set TMP_PATH=
