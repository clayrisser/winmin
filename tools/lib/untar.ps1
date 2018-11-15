param([string]$filename, [string]$cwd = '.', [string]$tools)
function Sanitize {
    param([string]$str)
    $str = $str -replace '` ', ' '
    $str = $str -replace ' ', '` '
    return $str
}
$cwd = Sanitize $cwd
$filename = Sanitize $filename
$tools = Sanitize $tools

$pathTo7ZipModule = "$tools\lib\7Zip4Powershell\1.8.0\7Zip4PowerShell.psd1"
if (-not (Test-Path $pathTo7ZipModule)) {
    Save-Module -Name 7Zip4Powershell -Force -Path "$tools\lib"
}

function Main {
    Untar $filename
}

function Untar {
    param([string]$tarFileName)
    $tarFilePath = "$cwd\$tarFileName"
    $extractPath = $cwd
    if (-not (Get-Command Expand-7Zip -ErrorAction Ignore)) {
        Import-Module $pathTo7ZipModule
    }
    Write-Output "Untaring $tarFilePath"
    Expand-7Zip $tarFilePath $extractPath
}

Main
