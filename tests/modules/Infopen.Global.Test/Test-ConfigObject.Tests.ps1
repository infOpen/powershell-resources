Set-StrictMode -Version Latest

<# Import function file #>
$srcFile = $MyInvocation.MyCommand.Path `
    -replace 'tests\\modules\\(.*?)\.Test\\(.*?)\.Tests\.ps1', `
             'src\modules\$1\$2.ps1'
. $srcFile

<# Tests #>
Describe 'Test-ConfigObject' {

    $cfgObject = @{ Foo = 'bar' }

    It 'should throw with null configObject param' {
        {
            Test-ConfigObject `
                -configObject $null `
                -mandatoryKeys @('Foo') `
                -validKeys @('Foo')
        } | Should Throw
    }

    It 'should throw with string configObject param' {
        {
            Test-ConfigObject `
                -configObject 'foo' `
                -mandatoryKeys @('Foo') `
                -validKeys @('Foo')
        } | Should Throw
    }

    It 'should throw with empty array configObject param' {
        {
            Test-ConfigObject `
                -configObject @() `
                -mandatoryKeys @('Foo') `
                -validKeys @('Foo')
        } | Should Throw
    }

    It 'should throw with null mandatoryKeys param' {
        {
            Test-ConfigObject `
                -configObject $cfgObject `
                -mandatoryKeys $null `
                -validKeys @('Foo')
        } | Should Throw
    }

    It 'should throw with string mandatoryKeys param' {
        $test = Test-ConfigObject `
                -configObject $cfgObject `
                -mandatoryKeys 'foo' `
                -validKeys @('Foo')
        $test | Should Throw
    }

    It 'should throw with null validKeys param' {
        {
            Test-ConfigObject `
                -configObject $cfgObject `
                -mandatoryKeys @('foo') `
                -validKeys $null
        } | Should Throw
    }

    It 'should throw with string validKeys param' {
        $test = Test-ConfigObject `
                -configObject $cfgObject `
                -mandatoryKeys @('foo') `
                -validKeys 'foo'
        $test | Should Throw
    }

    It 'should throw with empty array validKeys param' {
        {
            Test-ConfigObject `
                -configObject $cfgObject `
                -mandatoryKeys @('foo') `
                -validKeys $null
        } | Should Throw
    }

    It 'should return no error if valid' {
        [Array]$test = Test-ConfigObject `
                            -configObject $cfgObject `
                            -mandatoryKeys @('Foo') `
                            -validKeys @('Foo')
        $test | Should Be $null
    }

    It 'should return an error if extra key' {
        $cfgObject = @{ Foo = 'bar'; Bar = 'foo'}
        [Array]$test = Test-ConfigObject `
                            -configObject $cfgObject `
                            -mandatoryKeys @('foo') `
                            -validKeys @('foo')
        $test.length | Should Be 1
    }

    It 'should return one error if missing Param' {
        [Array]$test = Test-ConfigObject `
                            -configObject $cfgObject `
                            -mandatoryKeys @('Bar') `
                            -validKeys @('Foo', 'Bar')
        $test.length | Should Be 1
    }

    It 'should return two errors if missing an not valid Param' {
        [Array]$test = Test-ConfigObject `
                            -configObject $cfgObject `
                            -mandatoryKeys @('Bar2') `
                            -validKeys @('Bar2')
        $test.length | Should Be 2
    }
}
