function New-FlexaDocBaseURL {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $false,
			ValueFromPipeline = $true)]
		[String]
		$BaseURL
	)
		
	if (!$BaseURL) {
		Write-Host "Please enter your FlexaDoc Base URL with no trailing /, for example https://demo.flexadoccloud.com :"
		$BaseURL = Read-Host
	}
	Set-Variable -Name "Int_FlexaDocBaseURL" -Value $BaseURL -Visibility Private -Scope script -Force

	if ($script:Int_FlexaDocAPIKey) {
		[version]$Version = (Get-FlexaDocAppInfo).version
		if ($Version -lt $script:FlexaDocRequiredVersion) {
			Write-Host "A connection error occured or FlexaDoc version is below $script:FlexaDocRequiredVersion" -foregroundcolor yellow
		}
	}
}