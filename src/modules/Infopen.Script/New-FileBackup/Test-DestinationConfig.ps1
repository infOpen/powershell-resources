Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Validate destination key value of New-FileBackup

.DESCRIPTION
    This function check keys of destination object

.EXAMPLE
    Test-DestinationConfig -destinations $config

.PARAMETER destination
    Array of destination object
#>

function Test-DestinationConfig()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $destination
    )

    <# Import error module #>
    Import-Module Infopen.Error

    <# Import global module #>
    Import-Module Infopen.Global

    <# Valid top level keys for destinations config object #>
    $validTopLevelKeys = (
        'Path',
        'RetentionCount',
        'RetentionUnit',
        'Compress'
    )

    <# Mandatory top level keys for destinations config object #>
    $mdtyTopLevelKeys = (
        'Path'
    )

    <# Check if top level is valid #>
    return Test-ConfigObject `
                -configObject $destination `
                -mandatoryKeys $mdtyTopLevelKeys `
                -validKeys $validTopLevelKeys
}
