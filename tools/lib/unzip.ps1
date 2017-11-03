param([string]$file, [string]$cwd, [string]$tools)

Add-Type -AssemblyName System.IO.Compression.FileSystem

function Main {
    Unzip $file
}

function Unzip {
    param([string]$zipFileName)
    $zipFilePath = "$cwd\$zipFileName"
    $extractPath = $cwd
    Write-Output "Unzipping $zipFilePath"
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $extractPath)
}

Main
