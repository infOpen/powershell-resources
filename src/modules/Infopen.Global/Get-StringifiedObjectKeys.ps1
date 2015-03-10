Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Get keys of an object and store it to a string array

.DESCRIPTION
    This function get keys of an object and store it to a string array

.EXAMPLE
    Get-StringifiedObjectKeys -Obj $obj

.PARAMETER obj
    Object to parse
#>

function Get-StringifiedObjectKeys()
{
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.HashTable]$obj
    )

    $objKeys = @()
    $obj.Keys | ForEach-Object {
        $objKeys += $_.toString()
    }

    return $objKeys
}
