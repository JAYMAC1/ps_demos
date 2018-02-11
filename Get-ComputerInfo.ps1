Function Get-ComputerInfo {
    
    [CmdletBinding()]
    param(
        [parameter()]
        [string]$ComputerName = $env:COMPUTERNAME
    )
    BEGIN {
        Write-Verbose ("Starting Function")
    }
    PROCESS {
        foreach($Computer in $ComputerName){
            $continue = $true
            try {
                Write-Verbose ("Connecting to {0}" -f $Computer)
                $ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $Computer -ErrorAction Stop
            } catch {
                Write-Verbose ("Error: failed to connect to {0}" -f $Computer)
                $continue = $false
            }

            if($continue){
                $CompObject = [PSCustomObject][ordered]@{
                    'ComputerName'=$Computer;
                    'Domain'=$ComputerSystem.Domain;
                    'Manufacturer'=$ComputerSystem.Manufacturer;
                    'Model'=$ComputerSystem.Model;
                }

                Write-Output -InputObject $CompObject
            }
        }
    }
    END {}
}
Get-ComputerInfo