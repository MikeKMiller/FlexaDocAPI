function Get-FlexaDocMagicDashes {
	Param (
		[Alias("company_id")]
		[Int]$CompanyId = '',
		[String]$Title = ''
	)
	$ResourceFilter = ''

	if ($CompanyId) {
		$ResourceFilter = "$($ResourceFilter)&company_id=$($CompanyId)"
	}

	if ($Title) {
		$ResourceFilter = "$($ResourceFilter)&title=$($Title)"
	}
	
	$i = 1;
	$AllDashes = do {
		$Dashes = Invoke-FlexaDocRequest -Method get -Resource "/api/v1/fast_facts?page=$i&page_size=1000$($ResourceFilter)"
		$i++
		$Dashes
	} while ($Dashes.count % 1000 -eq 0 -and $Dashes.count -ne 0)
		
	return $AllDashes
	
}