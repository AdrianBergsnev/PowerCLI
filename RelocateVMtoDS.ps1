Import-Module Vmware.vimautomation.core

Connect-VIServer "Host"


$VMname = "VM"

$VMs = Get-VM "Cypher"

$DS = Get-Datastore -Name "Datastore"

$VMs | Move-VM -Datastore $DS

