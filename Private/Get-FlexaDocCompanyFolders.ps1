function Get-FlexaDocCompanyFolders {
    [CmdletBinding()]
    Param (
        [PSCustomObject]$FoldersRaw
    )
   
    $RootFolders = $FoldersRaw | Where-Object { $null -eq $_.parent_folder_id }
    $ReturnObject = [PSCustomObject]@{}
    foreach ($folder in $RootFolders) {
        $SubFolders = Get-FlexaDocSubFolders -id $folder.id -FoldersRaw $FoldersRaw
        foreach ($SubFolder in $SubFolders) {
            $Folder | add-member -Membertype NoteProperty -Name $(Get-FlexaDocFolderCleanName $($SubFolder.PSObject.Properties.name)) -Value $SubFolder.PSObject.Properties.value
        }
        $ReturnObject | add-member -Membertype NoteProperty -Name $(Get-FlexaDocFolderCleanName $($folder.name)) -Value $folder
    }
    return $ReturnObject
}