Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2\$3.ps1'
. $srcFile

<# Tests #>
Describe 'Test-TopLevelConfig' {

    It 'should throw with null param' {
        { Test-TopLevelConfig -configObject $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Test-TopLevelConfig -configObject $arrayTest } | Should Throw
    }

    It 'should throw with string param' {
        { Test-TopLevelConfig -configObject 'foo' } | Should Throw
    }

    It 'should throw if extra keys' {
        $configKeys = @{
            Foo = 'bar';
            Name = 'foo';
            Sources = @();
            Destination = @()
        }

        { Test-TopLevelConfig -configObject $configKeys } | Should Throw
    }

    It 'should throw if missing Name key' {
        $configKeys = @{
            Sources = @();
            Destination = @()
        }

        { Test-TopLevelConfig -configObject $configKeys } | Should Throw
    }

    It 'should throw if missing Sources key' {
        $configKeys = @{
            Name = 'foo';
            Destination = @()
        }

        { Test-TopLevelConfig -configObject $configKeys } | Should Throw
    }

    It 'should throw if missing Destination key' {
        $configKeys = @{
            Name = 'foo';
            Sources = @()
        }

        { Test-TopLevelConfig -configObject $configKeys } | Should Throw
    }

    It 'should return true if keys are valids' {
        $configKeys = @{
            Name = 'foo';
            Sources = @();
            Destination = @()
        }

        Test-TopLevelConfig -configObject $configKeys | Should Be $true
    }
}
