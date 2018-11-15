param(
    [string]$cmd,
    [string]$cwd = '.',
    [string]$tools,
    [switch]$elevated
)
function Sanitize {
    param([string]$str)
    $str = $str -replace '` ', ' '
    $str = $str -replace ' ', '` '
    return $str
}
$cmd = Sanitize $cmd
$cwd = Sanitize $cwd
$tools = Sanitize $tools

function Check-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Check-Admin) -eq $false)  {
    if ($elevated) {
        "Failed to elevate script"
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ("-noprofile -noexit -executionpolicy bypass -file $PSScriptRoot\elevate.ps1 -cmd `"$cmd`" -cwd $cwd -tools $tools -elevated" -f ($myinvocation.MyCommand.Definition))
        "Process elevated in another shell . . ."
    }
    stop-process -Id $PID
}
cmd.exe /c "cd $cwd && $cmd"
stop-process -Id $PID
