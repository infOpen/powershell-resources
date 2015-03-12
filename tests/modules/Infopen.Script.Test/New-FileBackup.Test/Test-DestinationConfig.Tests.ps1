Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2\$3.ps1'
. $srcFile

<# Tests #>
Describe 'Test-DestinationConfig' {

    It 'should throw with null param' {
        {
            Test-DestinationConfig -destination $null
        } | Should Throw
    }

    It 'should throw with string param' {
        {
            Test-DestinationConfig -destination 'foo'
        } | Should Throw
    }

    It 'should throw with empty array param' {
        {
            Test-DestinationConfig -destination 'foo'
        } | Should Throw
    }

    It 'should return an error if extra contents' {
        $destination = @{
            Path = 'foo';
            Foo = 'bar'
        }

        $test = Test-DestinationConfig -destination $destination
        $test.categoryInfo | Should Match 'InvalidData'
    }

    It 'should return an error if missing contents' {
        $destination = @{
            RetentionUnit = 'day'
        }

        $test = Test-DestinationConfig -destination $destination
        $test.categoryInfo | Should Match 'InvalidData'
    }

    It 'should return null if destination is ok (1)' {
        $destination = @{
            Path = 'foo';
        }

        Test-destinationConfig -destination $destination | Should Be $null
    }
}
