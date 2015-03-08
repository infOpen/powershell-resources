Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Check if a module is loaded

.DESCRIPTION
    This function check if a module is loaded

.EXAMPLE
    Test-ModuleLoaded -Name "foo"

.PARAMETER name
    Module name
#>

function Test-ModuleLoaded()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$name
    )

    if (Get-Module -Name "$name")
    {
        return $true
    }
    return $false
}
