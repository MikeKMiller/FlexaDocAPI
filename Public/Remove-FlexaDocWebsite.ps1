function Remove-FlexaDocWebsite {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id
  )
      
  $Response = Invoke-FlexaDocRequest -Method delete -Resource "/api/v1/websites/$Id"
    
  $Response
    
}