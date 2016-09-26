
$esx = "host.domain.com"

#Configure NTP server
Add-VmHostNtpServer -NtpServer "dmz.domain.com" -VMHost $esx 
Add-VmHostNtpServer -NtpServer "dmz.domain.com" -VMHost $esx 
#Allow NTP queries outbound through the firewall
Get-VMHostFirewallException -VMHost $esx | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true
#Start NTP client service and set to automatic
Get-VmHostService -VMHost $esx | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VmHostService -VMHost $esx | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"