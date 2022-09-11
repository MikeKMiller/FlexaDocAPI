function Set-FlexaDocCompanyArchive {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$Id,
        [Parameter(Mandatory = $true)]
        [Bool]$Archive
    )
    
    if ($Archive -eq $true) {
        $Response = Invoke-FlexaDocRequest -Method put -Resource "/api/v1/companies/$Id/archive"
    } else {
        $Response = Invoke-FlexaDocRequest -Method put -Resource "/api/v1/companies/$Id/unarchive"
    }
    $Response
}