Set-StrictMode -Version Latest

<# Extract repository modules path #>
$modulePath = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
        'src\modules'

<# Remove module if already loaded #>
if (Get-Module Infopen.Global)
{
    Remove-Module Infopen.Global
}

$modName = 'Infopen.Global'

<# Tests #>
Describe 'Infopen.Global' {

    BeforeEach {
        <# Backup $env:PSModulePath value #>
        $backupPSModulePath = $env:PSModulePath
        $env:PSModulePath = $env:PSModulePath + ";$modulePath"
    }

    AfterEach {
        <# Restore $env:PSModulePath value #>
        $env:PSModulePath = $backupPSModulePath
    }

    It 'should be loaded' {
        Import-Module Infopen.Global
    }

    Context 'Outside tests' {

        <# Get exported commands for this module #>
        $commands = Get-Command -Module Infopen.Global

        BeforeEach {
            $checkCmd = $null
            $func = $null
        }

        It 'should export Test-ModuleAvailable' {
            $func = 'Test-ModuleAvailable'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $func -and $_.Source -eq $modName
            })
            $checkCmd | Should Be $func
        }

        It 'should export Test-ModuleLoaded' {
            $func = 'Test-ModuleLoaded'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $func -and $_.Source -eq $modName
            })
            $checkCmd | Should Be $func
        }
    }

    It 'should be removed' {
        if (-not(Remove-Module Infopen.Global)) {
            Import-Module Infopen.Global
        }
    }
}
