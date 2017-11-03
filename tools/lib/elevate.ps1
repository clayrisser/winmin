param(
    [string]$cmd,
    [string]$cwd,
    [string]$tools,
    [switch]$elevated
)
function Check-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
    if ($elevated) {
        Write-Output "Failed to elevate script"
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ("-noprofile -noexit -executionpolicy bypass -file $PSScriptRoot\elevate.ps1 -cmd `"$cmd`" -cwd $cwd -tools $tools -elevated" -f ($myinvocation.MyCommand.Definition))
        Write-Output "Process elevated in another shell . . ."
    }
    exit
}
cmd.exe /c "cd $cwd && $cmd"
exit
