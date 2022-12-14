function Get-FlexaDocAssetLayoutFieldID {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Alias("asset_layout_id")]
		[Parameter(Mandatory = $true)]
		[Int]$LayoutId
	)
	
	$Layout = Get-FlexaDocAssetLayouts -layoutid $LayoutId
	
	$Fields = [Collections.Generic.List[Object]]($Layout.fields)
	$Index = $Fields.FindIndex( { $args[0].label -eq $Name } )
	$Fields[$Index].id
	
}