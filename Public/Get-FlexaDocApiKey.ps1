function Get-FlexaDocApiKey {
	[CmdletBinding()]
	Param()
	if ($null -eq $Int_FlexaDocAPIKey) {
		Write-Error "No API key has been set. Please use New-FlexaDocAPIKey to set it."
	} else {
		$Int_FlexaDocAPIKey
	}
}
