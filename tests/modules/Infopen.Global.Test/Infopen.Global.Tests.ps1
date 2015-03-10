Set-StrictMode -Version Latest

<# Extract repository modules path #>
$modulePath = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
        'src\modules'

<# Set name of module currently testing #>
$moduleName = 'Infopen.Global'

<# Remove module if already loaded #>
if (Get-Module $moduleName)
{
    Remove-Module $moduleName
}

<# Tests #>
Describe $moduleName {

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
        Import-Module $moduleName
    }

    Context 'Outside tests' {

        <# Get exported commands for this module #>
        $commands = Get-Command -Module $moduleName

        BeforeEach {
            $checkCmd = $null
            $functionName = $null
        }

        It 'should export Test-ModuleAvailable' {
            $functionName = 'Test-ModuleAvailable'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $functionName -and $_.Source -eq $moduleName
            })
            $checkCmd | Should Be $functionName
        }

        It 'should export Test-ModuleLoaded' {
            $functionName = 'Test-ModuleLoaded'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $functionName -and $_.Source -eq $moduleName
            })
            $checkCmd | Should Be $functionName
        }

        It 'should export Get-StringifiedObjectKeys' {
            $functionName = 'Get-StringifiedObjectKeys'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $functionName -and $_.Source -eq $moduleName
            })
            $checkCmd | Should Be $functionName
        }

        It 'should export Test-ArrayExtraContent' {
            $functionName = 'Test-ArrayExtraContent'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $functionName -and $_.Source -eq $moduleName
            })
            $checkCmd | Should Be $functionName
        }

        It 'should export Test-ArrayMissingContent' {
            $functionName = 'Test-ArrayMissingContent'
            $checkCmd = ($commands | Where-Object {
                $_.Name -eq $functionName -and $_.Source -eq $moduleName
            })
            $checkCmd | Should Be $functionName
        }
    }

    It 'should be removed' {
        if (-not(Remove-Module $moduleName)) {
            Import-Module $moduleName
        }
    }
}
