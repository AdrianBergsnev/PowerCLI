Import-Module Vmware.vimautomation.core

Connect-VIServer 192.168.0.9

$VMs = Get-VM -Name *16*

$DS = Get-Datastore -Name Logos

$VMs | Move-VM -Datastore $DS

