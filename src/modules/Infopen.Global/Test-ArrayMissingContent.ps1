Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Get keys of an object and store it to a string array

.DESCRIPTION
    This function get keys of an object and store it to a string array

.EXAMPLE
    Test-ArrayMissingContent -refContent $array1 -contentToCheck $array2

.PARAMETER refContent
    Reference array

.PARAMETER contentToCheck
    Array to compare with reference
#>

function Test-ArrayMissingContent()
{
    param(
        [Parameter(Mandatory = $true)]
        [Array]$refContent,

        [Parameter(Mandatory = $true)]
        [Array]$contentToCheck
    )

    $comp = Compare-Object $refContent $contentToCheck | Where-Object {
        $_.SideIndicator -eq '<='
    }

    return $comp
}
