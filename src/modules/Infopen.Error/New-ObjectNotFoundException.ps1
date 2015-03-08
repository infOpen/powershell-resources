Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Create a new ObjectNotFound exception

.DESCRIPTION
    This function create a new ObjectNotFound exception

.EXAMPLE
    New-ObjectNotFoundException -Message "File not found" -SouceObject $foo

.PARAMETER message
    Error message

.PARAMETER sourceObject
    Object which cause this error
#>

function New-ObjectNotFoundException()
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
    [System.Management.Automation.ItemNotFoundException]$exception = New-Object `
        -TypeName 'System.Management.Automation.ItemNotFoundException' `
        -ArgumentList $message

    <# Build error record #>
    [System.Management.Automation.ErrorRecord]$errorRecord = New-Object `
        -TypeName 'System.Management.Automation.ErrorRecord' `
        -ArgumentList `
            $exception, `
            'ItemNotFoundException', `
            ([System.Management.Automation.ErrorCategory]::ObjectNotFound), `
            $sourceObject

    return $errorRecord
}
