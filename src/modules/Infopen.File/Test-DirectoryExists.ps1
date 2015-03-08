Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Check if a directory exists

.DESCRIPTION
    This function check if a directory exists

.EXAMPLE
    Test-DirectoryExists -Path "C:\foo.bar"

.PARAMETER file
    Directory path
#>

function Test-DirectoryExists()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path
    )

    return Test-Path "$path" -PathType Container
}
