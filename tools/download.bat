@set CWD=%cd%
@set TOOLS=%~dp0

@call %TOOLS%lib\validate_powershell.bat

powershell -executionpolicy bypass -file %TOOLS%\lib\download.ps1 -url %1 -name %2 -cwd %CWD% -tools %TOOLS%
