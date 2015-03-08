Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Check if a file exists

.DESCRIPTION
    This function check if a file exists

.EXAMPLE
    Test-FileExists -Path "C:\foo.bar"

.PARAMETER path
    File path
#>

function Test-FileExists()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path
    )

    return Test-Path "$path" -PathType leaf
}
