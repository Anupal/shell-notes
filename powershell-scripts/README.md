# Powershell scripts

## Quick notes
- powershell commands follow the structure `<verb>-<now>`
    - for example `Get-Data`
- aliases exist like `gsv` for `Get-Service`
    - good for commandline, but avoid using them in scripts
    - can create your own aliases
    - use `Get-Alias` to get a list of current aliases

#### print powershell version
```powershell
PSVersionTable.PSVersion
```

#### command to find commands
```powershell
PS C:\Users\anupa> Get-Command -noun service

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-Service                                        7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          New-Service                                        7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Remove-Service                                     7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Restart-Service                                    7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Resume-Service                                     7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Set-Service                                        7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Service                                      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Service                                       7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Suspend-Service                                    7.0.0.0    Microsoft.PowerShell.Management
```

#### command to get information about a command
```powershell
Get-Help Get-Service -Full
```

### Mapping to Bash/sh
| Shell | Powershell |
|---|---|
| `cd C:\Users\` | `Set-Location -Path C:\Users\` |

### ExectionPolicy
- `Get-ExecutionPolicy`
- It is `RemoteSigned` for Windows 11
    - Allows script written by you or a trusted scripter (script will be signed)
- can be set using `Set-ExecutionPolicy -ExecutionPolicy <policy>`
- Other policies include
    - Default
    - AllSigned
    - Bypass
    - Restricted -> won't let you run any scripts whatsoever
    - Undefined
    - Unrestricted -> will let you run anything (dangerous)

# Special flags
- `-WhatIf` flag can be used to get an explanation about what the command will do
- `-Confirm` flag, similar to `-y` in Bash commands. It will not prompt you for confirmation.