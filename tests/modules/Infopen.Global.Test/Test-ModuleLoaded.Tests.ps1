Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-ModuleLoaded' {

    It 'should throw with null param' {
        { Test-ModuleLoaded -Name $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Test-ModuleLoaded -Name $arrayTest } | Should Throw
    }

    It 'should throw with empty string param' {
        { Test-ModuleLoaded -Name '' } | Should Throw
    }

    It 'should return false with not loaded module' {
        Mock Get-Module { }
        Test-ModuleLoaded -Name 'fooModule' | Should Be $false
    }

    It 'should return true with loaded module' {
        Mock Get-Module { [PSCustomObject]@{ Name = 'fooModule' } }
        Test-ModuleLoaded -Name 'fooModule' | Should Be $true
    }
}
