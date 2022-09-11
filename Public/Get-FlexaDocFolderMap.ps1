function Get-FlexaDocFolderMap {
	[CmdletBinding()]
	Param (
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	
	if ($CompanyId) {
		$FoldersRaw = Get-FlexaDocFolders -company_id $CompanyId
		$SubFolders = Get-FlexaDocCompanyFolders -FoldersRaw $FoldersRaw

	} else {
		$FoldersRaw = Get-FlexaDocFolders
		$FoldersProcessed = $FoldersRaw | where-Object { $null -eq $_.company_id }
		$SubFolders = Get-FlexaDocCompanyFolders -FoldersRaw $FoldersProcessed
	}

	return $SubFolders
}