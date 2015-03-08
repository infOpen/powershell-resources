Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Check if a module is available

.DESCRIPTION
    This function check if a module is available

.EXAMPLE
    Test-ModuleAvailable -Name "foo"

.PARAMETER name
    Module name
#>

function Test-ModuleAvailable()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$name
    )

    $checkMod = Get-Module -ListAvailable | Where-Object { $_.Name -eq "$name" }

    if ($checkMod)
    {
        return $true
    }
    return $false
}
