function Get-FlexaDocAppInfo {
    [CmdletBinding()]
    Param()
    try {
    
        $FlexaDocAPIKey = Get-FlexaDocApiKey
        $FlexaDocBaseURL = Get-FlexaDocBaseURL
	
        $version = Invoke-RestMethod -method get -uri ($FlexaDocBaseURL + "/api/v1/api_info") `
            -headers @{'x-api-key' = (New-Object PSCredential "user", $FlexaDocAPIKey).GetNetworkCredential().Password; } `
            -ContentType 'application/json'
		

    } catch {
        $version = @{
            version = "0.0.0.0"
            date    = "2000-01-01"
        }
    }


    return $Version
	
}