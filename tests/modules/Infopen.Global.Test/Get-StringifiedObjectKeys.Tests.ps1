Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Get-StringifiedObjectKeys' {

    It 'should throw with null param' {
        { Get-StringifiedObjectKeys -Obj $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Get-StringifiedObjectKeys -Obj $arrayTest } | Should Throw
    }

    It 'should throw with string param' {
        { Get-StringifiedObjectKeys -Obj 'foo' } | Should Throw
    }

    It 'should return empty array for an object without keys' {
        $expectedKeys = @()
        $objKeys = Get-StringifiedObjectKeys -Obj @{}

        <# Pester v3 method to check empty array #>
        ($objKeys -eq $null) | Should Be $true
    }

    It 'should return string array an object with keys stringified' {
        $obj = @{ Name = 'foo'; Foo = 'bar' }
        $expectedKeys = @('Name', 'Foo')
        Get-StringifiedObjectKeys -Obj $obj | Should Be $expectedKeys
    }
}
