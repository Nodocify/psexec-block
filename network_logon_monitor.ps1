$startDate = Get-Date
$newEvent = $false

while($true)
{
    $log = Get-Eventlog -LogName Security -after $startDate
    #Get-EventLog -LogName Security -Instance 4624 -Newest 2 | Where-Object {$_.ReplacementStrings[8] -eq 3}
    
    # Loop through each security event, print all login/logoffs with type, date/time, status, account name, and IP address if remote 
    foreach ($i in $log){ 
        # Logon Successful Events 
        if (($i.EventID -eq 4624) -and ($i.ReplacementStrings[8] -eq 3) -and ($i.ReplacementStrings[5] -ne "ANONYMOUS LOGON")){ 
            write-host "Type: Remote Logon`tDate: "$i.TimeGenerated "`tStatus: Success`tUser: "$i.ReplacementStrings[5] "`tNetBiosDN: "$i.ReplacementStrings[6] "`tIP Address: "$i.ReplacementStrings[18] -foregroundcolor "red"
            $newEvent = $true
        } 
         
        # Logon Failure Events, marked red 
        if (($i.EventID -eq 4625) -and ($i.ReplacementStrings[10] -eq 3)){ 
            write-host "Type: Remote Logon`tDate: "$i.TimeGenerated "`tStatus: Failure`tUser: "$i.ReplacementStrings[5] "`tDomain: "$i.ReplacementStrings[6] "`tIP Address: "$i.ReplacementStrings[19] 
            $newEvent = $true
        } 
         
        # Logoff Events 
        if (($i.EventID -eq 4634) -and ($i.ReplacementStrings[4] -eq 3)){ 
            write-host "Type: Remote Logoff`t`tDate: "$i.TimeGenerated "`tStatus: Success`tUser: "$i.ReplacementStrings[1] 
            $newEvent = $true
        }  
    }
    if ($newEvent){
        $startDate = Get-Date
        $newEvent = $false
    }
}