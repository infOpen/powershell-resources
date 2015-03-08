Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-DirectoryExists' {

    <# Create temp dir #>
    New-Item 'TestDrive:\fooDir' -Type directory

    <# Create temp file #>
    New-Item 'TestDrive:\fooFile' -Type file

    It 'should throw with null param' {
        { Test-DirectoryExists -Path $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Test-DirectoryExists -Path $arrayTest } | Should Throw
    }

    It 'should throw with empty string param' {
        { Test-DirectoryExists -Path '' } | Should Throw
    }

    It 'should return false with non existing directory' {
        Test-DirectoryExists -Path './foobarfile' | Should Be $false
    }

    It 'should return false with existing file' {
        Test-DirectoryExists -Path 'TestDrive:\fooFile' | Should Be $false
    }

    It 'should return true with existing directory' {
        Test-DirectoryExists -Path 'TestDrive:\fooDir' | Should Be $true
    }
}
