function Initialize-FlexaDocFolder {
    [CmdletBinding()]
    param(
        [String[]]$FolderPath,
        [Alias("company_id")]
        [int]$CompanyId
    )

    if ($CompanyId) {
        $FolderMap = Get-FlexaDocFolderMap -company_id $CompanyId
    } else {
        $FolderMap = Get-FlexaDocFolderMap
    }

    $CurrentFolder = $Foldermap
    foreach ($Folder in $FolderPath) {
        if ($CurrentFolder.$(Get-FlexaDocFolderCleanName $Folder)) {
            $CurrentFolder = $CurrentFolder.$(Get-FlexaDocFolderCleanName $Folder)
        } else {
            $CurrentFolder = (New-FlexaDocFolder -name $Folder -company_id $CompanyID -parent_folder_id $CurrentFolder.id).folder
        }
    }

    Return $CurrentFolder
}