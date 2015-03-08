Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Create a new InvalidData exception

.DESCRIPTION
    This function create a new InvalidData exception

.EXAMPLE
    New-InvalidDataException -Message "File not found" -SourceObject $foo

.PARAMETER message
    Error message

.PARAMETER sourceObject
    Object which cause this error
#>

function New-InvalidDataException()
{
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$message = 'No error message set',

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$sourceObject = 'No source object set'
    )

    <# Build exception #>
    [System.IO.InvalidDataException]$exception = New-Object `
        -TypeName 'System.IO.InvalidDataException' `
        -ArgumentList $message

    <# Build error record #>
    [System.Management.Automation.ErrorRecord]$errorRecord = New-Object `
        -TypeName 'System.Management.Automation.ErrorRecord' `
        -ArgumentList `
            $exception, `
            'InvalidDataException', `
            ([System.Management.Automation.ErrorCategory]::InvalidData), `
            $sourceObject

    return $errorRecord
}
