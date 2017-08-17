Import-Module Vmware.vimautomation.core

#E-Mail Section
$username = "USERNAME"
$password = "PASSWORD"
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$smtp = "SMTPSERVER"
$port = "587"
$from = "FROM"
$to = "TO"
$subject = "Warning: Temperature of $VMHost"
$body = "MESSAGE"
#E-Mail end

Connect-VIServer "vCENTER IP"

$Resetstatus = (Get-View (Get-VMHost -Name $VMHosts | Get-View).ConfigManager.HealthStatusSystem).ResetSystemHealthInfo()
$Refreshstatus = (Get-View (Get-VMHost -Name $VMHosts | Get-View).ConfigManager.HealthStatusSystem).RefreshHealthStatusSystem()
$VMHost = "HOSTNAME"
$VMHosts = @(
    "HOST IPs"
)
$Resetstatus 
$Refreshstatus
Get-VMHost -Name $VMHosts | Sort | % {
    $CPUtemp = ((Get-View $_.id).Runtime.HealthSystemRuntime.SystemHealthInfo.NumericSensorInfo | ? {$_.Name -like "*Processor 0 CPU*"}).CurrentReading | `
     Sort-Object temperatur | Select -Skip 4 

     $CPUtemp = $CPUtemp -replace "..$"
}
        Write-Host "$VMHost-CPU01 = $CPUtemp degrees"

    if ($CPUtemp -gt 35) {
        Write-Host "CPU too hot first time"

    } else {
        Write-Host "CPU Temperature OK"
    }


    if ($CPUtemp -gt 50) {
        Write-Host "CPU too hot second time, sending mail alerts to: $to"
           	
            Send-MailMessage -SmtpServer $smtp -Port $port -UseSsl -Credential $cred -From $from -To $to -Subject $subject -Body $body -BodyAsHtml -Verbose 
            
            }


