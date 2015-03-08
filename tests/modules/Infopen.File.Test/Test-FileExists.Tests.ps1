Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-FileExists' {

    <# Create temp dir #>
    New-Item 'TestDrive:\fooDir' -Type directory

    <# Create temp file #>
    New-Item 'TestDrive:\fooFile' -Type file

    It 'should throw with null param' {
        { Test-FileExists -Path $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Test-FileExists -Path $arrayTest } | Should Throw
    }

    It 'should throw with empty string param' {
        { Test-FileExists -Path '' } | Should Throw
    }

    It 'should return false with non existing file' {
        Test-FileExists -Path './foobarfile' | Should Be $false
    }

    It 'should return false with existing directory' {
        Test-FileExists -Path 'TestDrive:\fooDir' | Should Be $false
    }

    It 'should return true with existing file' {
        Test-FileExists -Path 'TestDrive:\fooFile' | Should Be $true
    }
}
