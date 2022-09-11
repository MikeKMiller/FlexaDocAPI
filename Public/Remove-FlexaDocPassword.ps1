function Remove-FlexaDocPassword {
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory = $true)]
    [Int]$Id
  )
    
  $Response = Invoke-FlexaDocRequest -Method delete -Resource "/api/v1/asset_passwords/$Id"
  
  $Response
  
}