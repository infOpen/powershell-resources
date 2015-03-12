Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2\$3.ps1'
. $srcFile

<# Tests #>
Describe 'Test-SourcesConfig' {

    It 'should throw with null param' {
        {
            Test-SourcesConfig -sources $null
        } | Should Throw
    }

    It 'should throw with string param' {
        {
            Test-SourcesConfig -sources 'foo'
        } | Should Throw
    }

    It 'should throw with empty array param' {
        {
            Test-SourcesConfig -sources 'foo'
        } | Should Throw
    }

    It 'should return an error if extra contents' {
        $sources = (
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
                Foo = 'bar'
            }
        )

       [Array]$test = Test-SourcesConfig -sources $sources
        $test.length | Should Be 1
    }

    It 'should return two errors if extra contents' {
        $sources = (
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
                Foo = 'bar'
            },
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
                Foo = 'bar'
            }
        )

        [Array]$test = Test-SourcesConfig -sources $sources
        $test.Length | Should Be 2
    }

    It 'should return an error if missing contents' {
        $sources = (
            @{
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            }
        )

        [Array]$test = Test-SourcesConfig -sources $sources
        $test.length | Should Be 1
    }

    It 'should return two errors if missing contents' {
        $sources = (
            @{
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            },
            @{
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            }
        )

        [Array]$test = Test-SourcesConfig -sources $sources
        $test.Length | Should Be 2
    }

    It 'should return null if sources is ok (1)' {
        $sources = (
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            }
        )

        Test-SourcesConfig -sources $sources | Should Be $null
    }

    It 'should return null if sources is ok (1)' {
        $sources = (
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            },
            @{
                Path = 'foo';
                Include = @();
                Exclude = @();
                Recursive = @();
                Depth = -1;
            }
        )

        Test-SourcesConfig -sources $sources | Should Be $null
    }
}
