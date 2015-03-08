Set-StrictMode -Version Latest

<# Extract repository modules path #>
$modulePath = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
        'src\modules'

<# Remove module if already loaded #>
if (Get-Module Infopen.File)
{
    Remove-Module Infopen.File
}

$modName = 'Infopen.File'

<# Tests #>
Describe 'Infopen.File' {

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
        Import-Module Infopen.File
    }

    Context 'Outside tests' {

        <# Get exported commands for this module #>
        $commands = Get-Command -Module Infopen.File

        BeforeEach {
            $checkCmd = $null
            $func = $null
        }

        It 'should export Test-FileExists' {
            $func = 'Test-FileExists'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $func -and $_.Source -eq $modName
            })
            $checkCmd | Should Be $func
        }

    }

    It 'should be removed' {
        if (-not(Remove-Module Infopen.File)) {
            Import-Module Infopen.File
        }
    }
}
