# Helper-script for MakeMeAdmin with LAPS
This PowerShell-script should help keeping the usage of [MakeMeAdmin](https://github.com/pseymour/MakeMeAdmin) in combination with [Windows Local Administrator Password Solution](https://github.com/pseymour/MakeMeAdmin) more secure.

### Configuration
**Note:** For the following, we assume that you use the `Settings`-section (`HKLM\SOFTWARE\Sinclair Community College\Make Me Admin\Allowed Entities`) and not the `Policies`-section (`HKLM\SOFTWARE\Policies\Sinclair Community College\Make Me Admin\Allowed Entities`) of `MakeMeAdmin`. However you can adjust it to your needs, of course, by editing the scripts.

You can use one of the files in the repository to configure the defaults for `MakeMeAdmin`, either the registry-file [`MakeMeAdmin_DefaultSettings.reg`](./MakeMeAdmin_DefaultSettings.reg) or the PowerShell-script [`MakeMeAdmin_DefaultSettings.ps1`](./MakeMeAdmin_DefaultSettings.ps1) (used the website at [Reg2PS](https://github.com/rzander/REG2CI/) to generate the PowerShell-file). This will ensure that by default no one can make herself admin, that the administrative permissions will endure for 30 minutes and that, when logging out, the user will be removed from the local administrators group. If needed, adjust the values in the scripts before executing.

- Save the script [`MakeMeAdminWithLAPS.ps1`](./MakeMeAdminWithLAPS.ps1) locally. Eventually you have to unblock it first.
- You can adjust the name of the LAPS-admin in `$credential` (`LAPSadmin` in the gist above). If you forgot to do this, you can adjust the name during execution.
- You can configure the period after which the user is removed *from the list of users, that are allowed to use `MakeMeAdmin`,* again (`$removal`, 30 seconds as default).
- If `$debug` (`$false`) is set to `$true`, the window will remain and show a bit more information. It's more a flag the you can use to output some more information if needed.

Adjust the invocation of the script, e. g. some batch-file, a shortcut, put it somewhere available in the `$PATH` for manual invocation, &hellip;

### Make! Me! Admin!
- If invoked, you are prompted for the credentials of the LAPS-admin initially. The good thing: you can user copy/paste to paste the LAPS-password here.
- Then a shell is started in the background with elevated rights, hence you are asked to confirm this. Somehow you need to do this in two steps: first start as admin-user, then elevate the permissions.
- In this shell, the current user is added to the registry in the `Allowed entities`-entry (see the [possible settings](https://github.com/pseymour/MakeMeAdmin/wiki/Registry-Settings) for `MakeMeAdmin`).
- You have now 30 seconds (depending on the configuration) to invoke `MakeMeAdmin` and grant admin-rights to the user. After this period, the user is removed again and you cannot make him admin anymore using `MakeMeAdmin`.
- Do all your administrative stuff, using the user/pass of the current user.
- Note that the timer from `MakeMeAdmin` will remove the user from the `Administrators`-group by itself.

# Caveat
There is no guarantee that the user is removed from the registry key again (e. g. if the background-job is stopped for whatever reason)! So you better check this (either invoke `MakeMeAdmin` and check if both buttons are disabled or check the registry key `HKLM\SOFTWARE\Sinclair Community College\Make Me Admin\Allowed Entities` and `HKLM\SOFTWARE\Policies\Sinclair Community College\Make Me Admin\Allowed Entities` before leaving the user on its own again.

