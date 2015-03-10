Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-ArrayMissingContent' {

    It 'should throw with null param' {
        {
            Test-ArrayMissingContent -refContent $null -contentToCheck @()
        } | Should Throw
    }

    It 'should throw with string param' {
        {
            Test-ArrayMissingContent -refContent 'foo' -contentToCheck @()
        } | Should Throw
    }

    It 'should be null if contents are equal' {
        $arrayA = @('foo', 'bar')
        $arrayB = @('foo', 'bar')

        Test-ArrayMissingContent -refContent $arrayA -contentToCheck $arrayB `
            | Should Be $null
    }

    It 'should be null if extra contents' {
        $arrayA = @('foo', 'bar')
        $arrayB = @('foo', 'bar', 'foobar')

        Test-ArrayMissingContent -refContent $arrayA -contentToCheck $arrayB `
            | Should Be $null
    }

    It 'should be true if missing contents' {
        $arrayA = @('foo', 'bar')
        $arrayB = @('bar')

        Test-ArrayMissingContent -refContent $arrayA -contentToCheck $arrayB `
            | Should Be $true
    }
}
