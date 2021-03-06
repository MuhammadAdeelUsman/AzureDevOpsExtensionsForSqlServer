function Get-SqlPackagePath {
<#
    .SYNOPSIS
    Find path to specific version of SqlPackage.exe

    .DESCRIPTION
    Finds the path to specific version of SqlPackage.exe

    Written by (c) Dr. John Tunnicliffe, 2019 https://github.com/DrJohnT/PublishDacPac
    This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT

    .PARAMETER Version
    Defines the specific version of SqlPackage.exe to which you wish to obtain the path
        latest = use the latest version of SqlPackage.exe
        150 = SQL Server 2019
        140 = SQL Server 2017
        130 = SQL Server 2016
        120 = SQL Server 2014
        110 = SQL Server 2012

    .OUTPUTS
    The full path to the specific version of SqlPackage.exe you requested

    .EXAMPLE
    Get-SqlPackagePath -Version 130

    Return the full path to a specific version of SqlPackage.exe

    .EXAMPLE
    Get-SqlPackagePath -Version latest

    Return the full path to a latest version of SqlPackage.exe

    .NOTES
    This module requires SqlPackage.exe to be installed on the host machine.
    This can be done by installing Microsoft SQL Server Management Studio from https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017

#>
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('150', '140', '130', '120', '110', 'latest')]
        [string]$Version
    )

    $ExeName = "SqlPackage.exe";
    try {
        # always return x64 version if present
        $SqlPackageExes = Get-Childitem -Path "${env:ProgramFiles}\Microsoft SQL Server\$Version" -Recurse -Include $ExeName -ErrorAction SilentlyContinue;
        foreach ($SqlPackageExe in $SqlPackageExes) {
            $SqlPackageExePath = $SqlPackageExe.FullName;
            $ProductVersion = $SqlPackageExe.VersionInfo | Select-Object ProductVersion;
            break;
        }

        if (!($SqlPackageExePath)) {
            # try to find x86 version
            $SqlPackageExes = Get-Childitem -Path "${env:ProgramFiles(x86)}\Microsoft SQL Server\$Version" -Recurse -Include $ExeName -ErrorAction SilentlyContinue;

            foreach ($SqlPackageExe in $SqlPackageExes) {
                $SqlPackageExePath = $SqlPackageExe.FullName;
                $ProductVersion = $SqlPackageExe.VersionInfo | Select-Object ProductVersion;
                break;
            }
        }

        if (!($SqlPackageExePath)) {
            $VsPaths = Resolve-Path "${env:ProgramFiles(x86)}\Microsoft Visual Studio\*\*\Common7\IDE\Extensions\Microsoft\SQLDB\DAC\$Version";
            foreach ($VsPath in $VsPaths) {
                $SqlPackageExes = Get-Childitem -Path $VsPath -Recurse -Include $ExeName -ErrorAction SilentlyContinue;
                foreach ($SqlPackageExe in $SqlPackageExes) {
                    $SqlPackageExePath = $SqlPackageExe.FullName;
                    $ProductVersion = $SqlPackageExe.VersionInfo | Select-Object ProductVersion;

                    break;
                    break;
                }
            }
        }

        if (!($SqlPackageExePath)) {
            $VsPaths = Resolve-Path "${env:ProgramFiles(x86)}\Microsoft Visual Studio*\Common7\IDE\Extensions\Microsoft\SQLDB\DAC\$Version";

            foreach ($VsPath in $VsPaths) {
                $SqlPackageExes = Get-Childitem -Path $VsPath -Recurse -Include $ExeName -ErrorAction SilentlyContinue;
                foreach ($SqlPackageExe in $SqlPackageExes) {
                    $SqlPackageExePath = $SqlPackageExe.FullName;
                    $ProductVersion = $SqlPackageExe.VersionInfo | Select-Object ProductVersion;
                    break;
                    break;
                }
            }
        }

        Write-Verbose "SqlPackage $ProductVersion found here $SqlPackageExePath";
    }
    catch {
        Write-Error "Get-SqlPackagePath failed with error $Error";
    }
    return $SqlPackageExePath;
}


