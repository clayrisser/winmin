@set CWD=%cd%
@set TOOLS=%~dp0

@call lib\validate_powershell.bat

powershell -executionpolicy bypass -file %TOOLS%lib\elevate.ps1 -cmd %1 -cwd %CWD% -tools %TOOLS%
