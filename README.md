# Restart Explorer context menu

Adds a **Restart Explorer** item to the Windows right-click menu — on the desktop and on
empty space inside a folder. Current user only, no admin required.

## Install

```powershell
irm https://raw.githubusercontent.com/RNDev666/explorer-restart-context-menu/main/install.ps1 | iex
```

## Uninstall

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/RNDev666/explorer-restart-context-menu/main/install.ps1))) -Uninstall
```

On Windows 11 the item appears under **Show more options** (or Shift+F10) — the modern
context menu only accepts entries from a signed MSIX package.
