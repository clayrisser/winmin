@set CWD=%cd%
@set TOOLS=%~dp0

@call lib\validate_powershell.bat

powershell -executionpolicy bypass -file %TOOLS%lib\unzip.ps1 -filename %1 -cwd %CWD% -tools %TOOLS%
