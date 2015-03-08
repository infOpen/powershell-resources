Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-ModuleAvailable' {

    It 'should throw with null param' {
        { Test-ModuleAvailable -Name $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Test-ModuleAvailable -Name $arrayTest } | Should Throw
    }

    It 'should throw with empty string param' {
        { Test-ModuleAvailable -Name '' } | Should Throw
    }

    It 'should return false with non existing module' {
        Mock Get-Module { }
        Test-ModuleAvailable -Name 'barModule' | Should Be $false
    }

    It 'should return true with existing module' {
        Mock Get-Module { [PSCustomObject]@{ Name = 'fooModule' } }
        Test-ModuleAvailable -Name 'fooModule' | Should Be $true
    }
}
