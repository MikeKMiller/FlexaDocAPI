function New-FlexaDocAsset {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Alias("company_id")]
		[Parameter(Mandatory = $true)]
		[Int]$CompanyId,
		[Alias("asset_layout_id")]
		[Parameter(Mandatory = $true)]
		[Int]$AssetLayoutId,
		[Array]$Fields,
		[Alias("primary_serial")]
		[string]$PrimarySerial,
		[Alias("primary_mail")]
		[string]$PrimaryMail,
		[Alias("primary_model")]
		[string]$PrimaryModel,
		[Alias("primary_manufacturer")]
		[string]$PrimaryManufacturer
	)
	
	$Asset = [ordered]@{asset = [ordered]@{} }
	
	$Asset.asset.add('name', $Name)
	$Asset.asset.add('asset_layout_id', $AssetLayoutId)


	if ($PrimarySerial) {
		$Asset.asset.add('primary_serial', $PrimarySerial)
	}

	if ($PrimaryMail) {
		$Asset.asset.add('primary_mail', $PrimaryMail)
	}

	if ($PrimaryModel) {
		$Asset.asset.add('primary_model', $PrimaryModel)
	}

	if ($PrimaryManufacturer) {
		$Asset.asset.add('primary_manufacturer', $PrimaryManufacturer)
	}

	if ($Fields) {
		$Asset.asset.add('custom_fields', $Fields)
	}
	
	$JSON = $Asset | convertto-json -Depth 10
	
	$Response = Invoke-FlexaDocRequest -Method post -Resource "/api/v1/companies/$CompanyId/assets" -body $JSON
	
	$Response
}