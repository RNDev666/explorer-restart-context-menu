<#
.SYNOPSIS
    Adds a "Restart Explorer" item to the Windows right-click menu (current user, no admin).
.EXAMPLE
    irm https://raw.githubusercontent.com/RNDev666/explorer-restart-context-menu/main/install.ps1 | iex
.EXAMPLE
    & ([scriptblock]::Create((irm https://raw.githubusercontent.com/RNDev666/explorer-restart-context-menu/main/install.ps1))) -Uninstall
#>
[CmdletBinding()]
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'

# Desktop background, and empty space inside a folder
$keys = @(
    'HKCU:\Software\Classes\DesktopBackground\Shell\RestartExplorer'
    'HKCU:\Software\Classes\Directory\Background\shell\RestartExplorer'
)

foreach ($key in $keys) {
    if ($Uninstall) {
        Remove-Item $key -Recurse -Force -ErrorAction SilentlyContinue
        continue
    }
    New-Item "$key\command" -Force | Out-Null
    Set-ItemProperty $key -Name 'MUIVerb'  -Value 'Restart Explorer'
    Set-ItemProperty $key -Name 'Icon'     -Value 'explorer.exe,0'
    Set-ItemProperty $key -Name 'Position' -Value 'Bottom'
    Set-ItemProperty "$key\command" -Name '(default)' -Value 'cmd.exe /c taskkill /f /im explorer.exe & start explorer.exe'
}

if ($Uninstall) {
    Write-Host 'Removed "Restart Explorer" from the context menu.'
} else {
    Write-Host 'Added "Restart Explorer" to the context menu.'
    # Write-Host 'On Windows 11 it lives under "Show more options" (Shift+F10).'
}
