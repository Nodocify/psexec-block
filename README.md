# PSExec-block

This project aims to make a machine look vulnerable to psexec while blocking any action but capturing the login attempts.

## Directions:

1. Make sure that both Network Discovery and File and Printer Sharing are both enabled.
2. Run the following command from an elevated command prompt.
   ```
   REG ADD "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0
   ```
3. Run ```secpol.msc```. Under Local Policies select Audit Policies. Set the Audit Logon Events to both Success and Failure.
4. Reboot the machine.
5. Use powershell script or any other log monitoring system to now monitor connection attempts.


This disables ALL shares for the workstation. But the SMB server is still running allowing people to attempt to authenticate.

Do NOT do this on a domain controller!!
