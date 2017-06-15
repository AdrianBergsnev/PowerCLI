Get-VM | Select Name, @{N="Cluster";E={Get-Cluster -VM $_}}, `
@{N="Host";E={Get-VMHost -VM $_}}, `
@{N="Datastore";E={Get-Datastore -VM $_}} 