Set-StrictMode -Version Latest

<#
.SYNOPSIS
    check config object keys for missing or bad keys

.DESCRIPTION
    This function check config object keys for missing or bad keys

.EXAMPLE
    Test-ConfigObject -configObject $config

.PARAMETER configObject
    Object to process

.PARAMETER mandatoryKeys
    Mandatory keys for this object

.PARAMETER validKeys
    Valid keys for this object
#>

function Test-ConfigObject()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Object]$configObject,

        [Parameter(Mandatory = $true)]
        [AllowNull()]
        [String[]]$mandatoryKeys,

        [Parameter(Mandatory = $true)]
        [AllowNull()]
        [String[]]$validKeys
    )

    <# Import error module #>
    Import-Module Infopen.Error

    <# Array to store errors #>
    $errors = @()

    <# Top level keys of config object #>
    [Array]$sourceKeys = Get-StringifiedObjectKeys -Obj $configObject

    <# Check if config object contains invalid top level keys #>
    [Array]$extraKeys = Test-ArrayExtraContent $validKeys $sourceKeys

    <# Check if config object has missing mandatory top level keys #>
    [Array]$missingKeys = Test-ArrayMissingContent $mandatoryKeys $sourceKeys


    if ($extraKeys)
    {
        $errorObject = New-InvalidDataException `
            -Message 'Bad keys in config content' `
            -SourceObject $configObject
        $errors += $errorObject
    }

    if ($missingKeys)
    {
        $errorObject = New-InvalidDataException `
            -Message 'Missing keys in config content' `
            -SourceObject $configObject
        $errors += $errorObject
    }

    return $errors
}
