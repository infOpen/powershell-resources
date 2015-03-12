Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2\$3.ps1'
. $srcFile

<# Tests #>
Describe 'Test-LoggingConfig' {

    It 'should throw with null param' {
        {
            Test-LoggingConfig -logging $null
        } | Should Throw
    }

    It 'should throw with string param' {
        {
            Test-LoggingConfig -logging 'foo'
        } | Should Throw
    }

    It 'should throw with empty array param' {
        {
            Test-LoggingConfig -logging 'foo'
        } | Should Throw
    }

    It 'should return an error if extra contents' {
        $logging = @{
            eventLogName = 'foo';
            Foo = 'bar'
        }

        $test = Test-LoggingConfig -logging $logging
        $test.categoryInfo | Should Match 'InvalidData'
    }

    It 'should return an error if missing contents' {
        $logging = @{
            Level = 'debug'
        }

        $test = Test-LoggingConfig -logging $logging
        $test.categoryInfo | Should Match 'InvalidData'
    }

    It 'should return null if logging is ok (1)' {
        $logging = @{
            eventLogName = 'foo';
        }

        Test-LoggingConfig -logging $logging | Should Be $null
    }
}
