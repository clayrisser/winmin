@set CWD=%cd%
@set TOOLS=%~dp0

@call lib\validate_powershell.bat

powershell -executionpolicy bypass -file %TOOLS%\unzip.ps1 -file %1 -cwd %CWS% -tools %TOOLS%
