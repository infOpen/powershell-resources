Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Validate logging key value of New-FileBackup

.DESCRIPTION
    This function check keys of logging object

.EXAMPLE
    Test-LoggingConfig -loggings $config

.PARAMETER logging
    Array of logging object
#>

function Test-LoggingConfig()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $logging
    )

    <# Import error module #>
    Import-Module Infopen.Error

    <# Import global module #>
    Import-Module Infopen.Global

    <# Valid top level keys for loggings config object #>
    $validTopLevelKeys = (
        'eventLogName',
        'level'
    )

    <# Mandatory top level keys for loggings config object #>
    $mdtyTopLevelKeys = (
        'eventLogName'
    )

    <# Check if top level is valid #>
    return Test-ConfigObject `
                -configObject $logging `
                -mandatoryKeys $mdtyTopLevelKeys `
                -validKeys $validTopLevelKeys
}
