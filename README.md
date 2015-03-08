# powershel-resources

## Description

powershell-resources is a set of Powershell modules and script who can use in your projects.

From the beginning, the rules are :
  - 100% code coverage
  - well documented

## Modules

Actually, it's small, but we have initialize these modules :
### Infopen.File
This module contains high level functions to manage files and folders
### Infopen.Module
This module contains high level functions to manage files and folders

## Unit testing

All the code is covered by unit tests, and for that we use Pester project.

To launch tests (from root path) :
``` powershell
Invoke-Pester
```
To launch tests and coverage (from root path) :
``` powershell
Invoke-Pester -CodeCoverage .\src\*\*\*
```

## Development

Want to contribute? Great!

Just follow these rules :


## License
MIT

## Links
Here are links who have help me to realize this project :
* [MSDN] : MSDN
* [Powershell Magazine] Good reference
* [Powershell Scripting] Another script reference
* [Pester Project] Unit testing framework

[MSDN]: https://msdn.microsoft.com
[Powershell Magazine]: http://www.powershellmagazine.com
[Pester Project]: https://github.com/pester/Pester
[Powershell Scripting]: http://www.powershell-scripting.com
