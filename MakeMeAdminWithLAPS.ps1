# Getting the current user that we would like to make admin
$current_user = "$env:USERDOMAIN\$env:USERNAME"
# The name of the LAPS-admin
$credential = Get-Credential "$env:COMPUTERNAME\LAPSadmin"
# When should the user be removed again (in seconds)?
$removal = 30
# Should the window be visible?
$debug = $false
# The command entering the user in the registry in the appropriate folder
# Policies at HKLM:\SOFTWARE\Policies\Sinclair Community College\Make Me Admin
# Settings at HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin
$args = "`"-Command &{ Set-ItemProperty 'HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin' -Name 'Allowed Entities' -Type MultiString -Value '${current_user}'; Start-Sleep -Seconds $removal; Clear-ItemProperty 'HKLM:\SOFTWARE\Sinclair Community College\Make Me Admin' -Name 'Allowed Entities'}`""
# The command elevating the process
$sb = [ScriptBlock]::Create("Start-Process PowerShell -ArgumentList $args -Verb RunAs -Wait" + $(if ($debug -eq $false) {" -WindowStyle Hidden"} else {" -WindowStyle Normal"}))
#if ($debug) {Write-Host $sb}

#Start the job as LAPS-admin
$GetProcessJob = Start-Job -ScriptBlock $sb -Credential $credential
#Wait until the job is completed
Wait-Job $GetProcessJob
#Get the job results
$GetProcessResult = Receive-Job -Job $GetProcessJob
#Print the Job results
$GetProcessResult
if ($debug) {
  Write-Host "Press any key to continue..."
  $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
