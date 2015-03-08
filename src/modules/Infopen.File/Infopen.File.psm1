Set-StrictMode -Version Latest

<# Import functions for the module #>
Get-ChildItem $PSScriptRoot\*.ps1 -Recurse | % { . $_.FullName }
