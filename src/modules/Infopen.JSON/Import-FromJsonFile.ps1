Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Import JSON content

.DESCRIPTION
    This function import JSON content and transform it to a powershell object

.EXAMPLE
    Import-FromJson -Path "C:\foo.json"

.PARAMETER path
    file path
#>

function Import-FromJsonFile()
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path
    )

    <# Import Infopen.File to check if JSON file exists #>
    Import-Module Infopen.File

    if (Test-FileExists -Path $path)
    {
        return Get-Content $path -Raw | ConvertFrom-Json
    }
    else
    {
        $errorObject = New-ObjectNotFoundException `
            -Message 'File not found' `
            -SourceObject $path

        throw $errorObject
    }
}
