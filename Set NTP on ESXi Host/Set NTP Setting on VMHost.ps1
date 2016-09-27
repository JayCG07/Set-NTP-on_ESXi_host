
#----Add host name
$esxihost = "host1.domain.com"

#----Configure NTP server
Add-VmHostNtpServer -NtpServer "dmz.domain.com" -VMHost $esxihost 
Add-VmHostNtpServer -NtpServer "dmz.domain.com" -VMHost $esxihost 

#----Setup firewall 
Get-VMHostFirewallException -VMHost $esxihost | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true

#----Start NTP service and set to automatic
Get-VmHostService -VMHost $esxihost | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VmHostService -VMHost $esxihost | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"