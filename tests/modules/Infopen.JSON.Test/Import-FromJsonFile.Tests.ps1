Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
        -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
                 'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Import-FromJsonFile' {

    <# Create a good json file #>
    New-Item 'TestDrive:\good.json' -Type file
    Add-Content 'TestDrive:\good.json' '{"foo":"bar"}'

    <# Create a bad json file #>
    New-Item 'TestDrive:\bad.json' -Type file
    Add-Content 'TestDrive:\bad.json' '{"foo"}'

    It 'should throw with null param' {
        { Import-FromJsonFile -Path $null } | Should Throw
    }

    It 'should throw with array param' {
        $arrayTest = 'a', 'b'
        { Import-FromJsonFile -Path $arrayTest } | Should Throw
    }

    It 'should throw with empty string param' {
        { Import-FromJsonFile -Path '' } | Should Throw
    }

    It 'should throw if file not exists' {
        { Import-FromJsonFile -Path 'TestDrive:\badPath.json' } | Should Throw
    }

    It 'should throw with invalid JSON' {
        { Import-FromJsonFile -Path 'TestDrive:\bad.json' } | Should Throw
    }

    It 'should return a powershell object if JSON is valid' {
        $PSObject = Import-FromJsonFile -Path 'TestDrive:\good.json'
        $PSObject.foo | Should Be 'bar'
    }
}
