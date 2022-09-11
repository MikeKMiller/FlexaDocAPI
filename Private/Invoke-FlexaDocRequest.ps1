function Invoke-FlexaDocRequest {
	[CmdletBinding()]
	Param(
		[string]$Method,
		[string]$Resource,
		[string]$Body
	)
	
	write-verbose "Method: $Method"
	write-verbose "Resource: $Resource"
	write-verbose "Body: $($Body | out-string)"
	write-verbose "BaseURL: $(Get-FlexaDocBaseURL)"

	try {
		if (($Method -eq "put") -or ($Method -eq "post") -or ($Method -eq "delete")) {
			$FlexaDocAPIKey = Get-FlexaDocApiKey
			$FlexaDocBaseURL = Get-FlexaDocBaseURL
			$FlexaDocResult = Invoke-RestMethod -method $method -uri ($FlexaDocBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user", $FlexaDocAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8' -body $Body			

		} else {	
			$FlexaDocAPIKey = Get-FlexaDocApiKey
			$FlexaDocBaseURL = Get-FlexaDocBaseURL
			$FlexaDocResult = Invoke-RestMethod -method $method -uri ($FlexaDocBaseURL + $Resource) `
				-headers @{'x-api-key' = (New-Object PSCredential "user", $FlexaDocAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8'
		}


	} catch {
		if ("$_".trim() -eq "Retry later" -or "$_".trim() -eq "The remote server returned an error: (429) Too Many Requests.") {
			Write-Host "FlexaDoc API Rate limited. Waiting 30 Seconds then trying again" -foregroundcolor red
			Start-Sleep 30
			$FlexaDocResult = Invoke-FlexaDocRequest -Method $method -Resource $resource -Body $Body
		} else {
			Write-Error "'$_'"
		}
	}
	
	return $FlexaDocResult
	
}