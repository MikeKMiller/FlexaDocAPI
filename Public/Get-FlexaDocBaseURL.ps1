function Get-FlexaDocBaseURL {
	[CmdletBinding()]
	Param()
	if ($null -eq $Int_FlexaDocBaseURL) {
		Write-Error "No Base URL has been set. Please use New-FlexaDocBaseURL to set it."
	} else {
		$Int_FlexaDocBaseURL
	}
}
