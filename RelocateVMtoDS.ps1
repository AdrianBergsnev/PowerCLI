Import-Module Vmware.vimautomation.core

Connect-VIServer 192.168.0.9

$VMs = @(
"WIN - Morpheus"
"LIN - Cypher"
)

$VMcomm = Get-VM -Name $VMs

$DS = Get-Datastore -Name Ghost



$VMcomm | Move-VM -Datastore $DS
