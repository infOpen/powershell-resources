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

    <# If keys are ok, check values type #>
    if (-not $errors)
    {

        <# Check Name value #>
        if (-not $configObject.Name -is [String] -or $configObject.Name -eq '')
        {
            $errorObject = New-InvalidDataException `
                -Message 'Bad value for Name key' `
                -SourceObject $configObject.Name
            $errors += $errorObject
        }

        <# Check Sources value #>
        if (-not $configObject.Sources -is [System.Object[]] `
             -and $configObject.Sources.Length -ne 0)
        {
            $errorObject = New-InvalidDataException `
                -Message 'Bad value for Sources key' `
                -SourceObject $configObject.Sources
            $errors += $errorObject
        }

        <# Check Destination value #>
        if (-not $configObject.Destination -is [Hashtable])
        {
            $errorObject = New-InvalidDataException `
                -Message 'Bad value for Destination key' `
                -SourceObject $configObject.Destination
            $errors += $errorObject
        }

        <# Recheck errors before return #>
        if (-not $errors)
        {
            return $true
        }
        else
        {
            throw $errors
        }
    }
    else
    {
        throw errors
    }
}
