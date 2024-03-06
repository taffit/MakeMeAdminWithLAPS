# Reg2CI (c) 2022 by Roger Zander
try {
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin")){ return $false };

#  Number in minutes, in the example: 30 (see `-eq 30`)
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin' -Name 'Admin Rights Timeout' -ea SilentlyContinue) -eq 30) {  } else { return $false };

#  If user logs out, the admin-rights should be removed as well
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin' -Name 'Remove Admin Rights On Logout' -ea SilentlyContinue) -eq 1) {  } else { return $false };

#  If empty, no user can make herself admin
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin' -Name 'Allowed Entities' -ea SilentlyContinue) -join ',' -eq '""') {  } else { return $false };
}
catch { return $false }
return $true