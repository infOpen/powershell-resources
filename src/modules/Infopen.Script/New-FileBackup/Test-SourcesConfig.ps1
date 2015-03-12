Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Validate Source key value of New-FileBackup

.DESCRIPTION
    This function check if it's an object array and keys of each object

.EXAMPLE
    Test-SourcesConfig -configObject $config

.PARAMETER sources
    Array of sources object
#>

function Test-SourcesConfig()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Object[]]$sources
    )

    <# Import error module #>
    Import-Module Infopen.Error

    <# Import global module #>
    Import-Module Infopen.Global

    <# Valid top level keys for sources config object #>
    $validTopLevelKeys = (
        'Path',
        'Include',
        'Exclude',
        'Recursive',
        'Depth'
    )

    <# Mandatory top level keys for sources config object #>
    $mdtyTopLevelKeys = (
        'Path'
    )

    <# Array to store errors #>
    $errors = @()

    <# Iterate over each source object to check keys #>
    $sources | ForEach-Object {

        $sourceObject = $_

        <# Check if top level is valid #>
        $errors += Test-ConfigObject `
                            -configObject $sourceObject `
                            -mandatoryKeys $mdtyTopLevelKeys `
                            -validKeys $validTopLevelKeys
    }

    return $errors
}
