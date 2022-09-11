function Get-FlexaDocSubFolders {
    [CmdletBinding()]
    Param(
        [int]$id,
        [PSCustomObject]$FoldersRaw
    )

    $SubFolders = $FoldersRaw | where-Object { $_.parent_folder_id -eq $id } 
    $ReturnFolders = [System.Collections.ArrayList]@()
    foreach ($Folder in $SubFolders) {
        $SubSubFolders = Get-FlexaDocSubFolders -id $Folder.id -FoldersRaw $FoldersRaw
        foreach ($AddFolder in $SubSubFolders) {
            $null = $folder | add-member -Membertype NoteProperty -Name $(Get-FlexaDocFolderCleanName $($AddFolder.PSObject.Properties.name)) -Value $AddFolder.PSObject.Properties.value
        }
        $ReturnObject = [PSCustomObject]@{
            $(Get-FlexaDocFolderCleanName $($Folder.name)) = $Folder
        }
        $null = $ReturnFolders.add($ReturnObject)
    }

    return $ReturnFolders

}