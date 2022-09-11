function New-FlexaDocAPIKey {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $false,
			ValueFromPipeline = $true)]
		[String]
		$ApiKey
	)
		
	if ($ApiKey) {
		$SecApiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force
	} else {
		Write-Host "Please enter your FlexaDoc API key, you can obtain it from https://your-flexadoc-domain/admin/api_keys:"
		$SecApiKey = Read-Host -AsSecureString
	}
	Set-Variable -Name "Int_FlexaDocAPIKey" -Value $SecApiKey -Visibility Private -Scope script -Force

	if ($script:Int_FlexaDocBaseURL) {
		[version]$version = (Get-FlexaDocAppInfo).version
		if ($version -lt $script:FlexaDocRequiredVersion) {
			Write-Host "A connection error occured or FlexaDoc version is below $script:FlexaDocRequiredVersion" -foregroundcolor yellow
		}
	}
}