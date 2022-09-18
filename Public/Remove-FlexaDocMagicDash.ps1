function Remove-FlexaDocMagicDash {
	[CmdletBinding()]
	Param (
		[String]$Title = '',
		[Alias("company_name")]
		[String]$CompanyName = '',
		[String]$Id = ''
	)
	
	if ($id) {
		$null = Invoke-FlexaDocRequest -Method delete -Resource "/api/v1/fast_fact/$Id"
	
	} else {

		if ($Title -and $CompanyName) {
	
			$MagicDash = @{}
	
			$MagicDash.add('title', $Title)
			$MagicDash.add('company_name', $CompanyName)
				
			$JSON = $MagicDash | convertto-json
	
			$null = Invoke-FlexaDocRequest -Method delete -Resource "/api/v1/fast_fact" -body $JSON
	
		} else {
			Write-Host "ERROR: Please set title and company_name" -ForegroundColor Red
		}
	
	}
}