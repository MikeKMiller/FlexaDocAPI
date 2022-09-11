function Set-FlexaDocFolder {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[Int]$Id,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[String]$Icon = '',
		[String]$Description = '',
		[Alias("parent_folder_id")]
		[Int]$ParentFolderId = '',
		[Alias("company_id")]
		[Int]$CompanyId = ''
	)
	
	$Folder = [ordered]@{folder = [ordered]@{} }
	
	$Folder.folder.add('name', $Name)
		
	if ($icon) {
		$Folder.folder.add('icon', $Icon)
	}
	
	if ($Description) {
		$Folder.folder.add('description', $Description)
	}
	
	if ($ParentFolderId) {
		$Folder.folder.add('parent_folder_id', $ParentFolderId)
	}
	
	if ($CompanyId) {
		$Folder.folder.add('company_id', $CompanyId)
	}
		
	$JSON = $Folder | convertto-json
	
	$Response = Invoke-FlexaDocRequest -Method put -Resource "/api/v1/folders/$Id" -body $JSON
	
	$Response
}