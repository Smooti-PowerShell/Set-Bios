<#
    .DESCRIPTION
        Automatically configure BIOS settings
        SetBIOSSetting Return Codes
        0 - Success
        1 - Not Supported
        2 - Unspecified Error
        3 - Timeout
        4 - Failed - (Check for typos in the setting value)
        5 - Invalid Parameter
        6 - Access Denied - (Check that the BIOS password is correct)
    .NOTES
        Author: Robert Owens
        Created: December 30, 2020
#>
param (
	[Parameter(mandatory = $true)]
	[string] $Setting,

	[Parameter(mandatory = $true)]
	[string] $Value,

	[Parameter(mandatory = $false)]
	[SecureString] $Password
)

$ErrorActionPreference = "SilentlyContinue"
Import-Module -Name "$($PSScriptRoot)\Modules\MasterFunctions"

switch (Get-Manufacturer) {
	"HP" {
		Set-HPBIOSSetting -setting $Setting -value $Value -Password $Password
	}
	"DELL" {
		Import-Module -Name "$($PSScriptRoot)\Modules\DellBIOSProvider"
		Set-DellBIOSSetting -Setting $Setting -value $Value -Password $Password
	}
	"Lenovo" {
		Set-LenovoBIOSSetting -Setting $Setting -value $Value -Password $Password
	}
}
