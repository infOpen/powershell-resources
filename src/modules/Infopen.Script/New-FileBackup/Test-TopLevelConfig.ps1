Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Validate top level keys from config for Create-FileBackup script

.DESCRIPTION
    This function check if top level keys from config for Create-FileBackup
    are valid

.EXAMPLE
    Test-TopLevelConfig -configObject $config

.PARAMETER configObject
    Configuration object
#>

function Test-TopLevelConfig()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Object]$configObject
    )

    <# Import error module #>
    Import-Module Infopen.Error

    <# Import global module #>
    Import-Module Infopen.Global

    <# Valid top level keys for this config object #>
    $validTopLevelKeys = (
        'Name',
        'Sources',
        'Destination',
        'Logging'
    )

    <# Mandatory top level keys for this config object #>
    $mdtyTopLevelKeys = (
        'Name',
        'Sources',
        'Destination'
    )

    <# Check if top level is valid #>
    $errors = Test-ConfigObject `
                        -configObject $configObject `
                        -mandatoryKeys $mdtyTopLevelKeys `
                        -validKeys $validTopLevelKeys

    if ($errors)
    {
        throw errors
    }
    else
    {
        return $true
    }
}
