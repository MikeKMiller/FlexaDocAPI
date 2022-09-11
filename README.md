
## Release Notes
### Version 2.2.0
```
Added Get-FlexaDocExpirations
```
### Version 2.1.1
```
Fix for Get-FlexaDocFolders by ID
Fix for Initialize-FlexaDocFolder creating folders in company
```
### Version 2.1.0
```
Added the ability to set primary_serial, primary_mail, primary_model, primary_manufacturer to New-FlexaDocAsset and Set-FlexaDocAsset
Set fields to be optional for New-FlexaDocAsset and Set-FlexaDocAsset
```
### Version 2.0.0-alpha1
Added Get-FlexaDocProcesses
### Version 2.0.0-alpha
```
Added support for 2.1.5.8
Switched to Semver
Added Get-FlexaDocMagicDashes
Added Get-FlexaDocRelations
Added New-FlexaDocRelation
Added Remove-FlexaDocRelation
General tweaks and bug fixes
```

### Version 1.22

Fixes an incorrect ID parameter for `Get-FlexaDocWebsite`.
Adds more new API endpoints/parameters for FlexaDoc 2.1.5.6

### Version 1.21
Refixed A missed / in Get Assets by ID

### Version 1.20
Various fixes from pull requests (Thank you homotechsual and greenlighttec)
Added aliases to all commands
Fixed camel case
Some incorrect filter names
A missed / in Get Assets by ID

### Version 1.19
Added Boolean fix to Set-FlexaDocAssetLayouts
Fixed bug in Remove-MagicDash

### Version 1.18
Added Support for FlexaDoc 2.1.5.6 and implemented Folders

Added:

	Get-FlexaDocFolders
	New-FlexaDocFolder
	Set-FlexaDocFolder

I have also added some additional helper features for folders

	Get-FlexaDocFolderMap # will return the structure of all folders in your KB
	Get-FlexaDocFolderMap -company_id $company.id # will return the structure of folders under a customer.
	
You can browse to folders with

	(Get-FlexaDocFolderMap).Folder.SubFolder.SubSubFolder

To get a specific subfolder by path or to create it and its parent folders you can pass in an array of strings to Initialize-FlexaDocFolder:

	$Folders = @("Folder","SubFolder","SubSubFolder")
	Initialize-FlexaDocFolder $Folders

Fixed bug in 2.1.5.6 where booleans have been fixed in asset layouts, but legacy text versions no longer work.

### Version 1.17

Fixed rate limiting in PowerShell 5

### Version 1.16

Fixed issues with UTF8 characters. Invalid characters should be stripped and correct characters sent now.

### Version 1.15

More tweaks to work around the json order issue.

### Version 1.14

Fixes for Powershell 7

FlexaDoc has an API bug where JSON needs to be in the correct order. The module works fine with PS5 but Asset fields weren't created in PS7, This version fixes that.

### Version 1.13

Rate Limiting and Version Check

This update adds in handling for FlexaDoc's API rate limiting. It also adds support for the new AppInfo endpoint and will check your version when both BaseURL and API key have been set. It also fixes the Get-FlexaDocCard command.

## Notes

This is an unofficial powershell module to allow access to the FlexaDoc API. I am not associated with FlexaDoc other than as a customer.

The main change is you now need to provide fields to an asset as:

"field_name": "value"

Where field name is the asset layout field name in lower case with spaces converted to _

In the prior version you needed to provide

"asset_layout_field_id": 1

"value": "value"

I have updated my MSP360 script in Github with the changes to work with the latest version. This version is much faster due to the new filtering options and shows the new asset field style needed:



The filter options on get commands are all optional.


## Installation

    install-module FlexaDocAPI

## Implemented Commands
		New-FlexaDocAPIKey
		Get-FlexaDocAPIKey
		Remove-FlexaDocAPIKey
		New-FlexaDocBaseURL
		Get-FlexaDocBaseURL
		Remove-FlexaDocBaseURL
		Get-FlexaDocAssets
		Invoke-FlexaDocRequest
		Get-FlexaDocCompanies
		Get-FlexaDocAssetLayouts
		Get-FlexaDocWebsites
		New-FlexaDocWebsite
		Set-FlexaDocMagicDash
		Remove-FlexaDocMagicDash
		New-FlexaDocAssetLayout
		Get-FlexaDocAssetLayoutFieldID
		New-FlexaDocAsset
		Set-FlexaDocAsset
		Get-FlexaDocArticles
		New-FlexaDocArticle
		Set-FlexaDocArticle
		Get-FlexaDocPasswords
		Set-FlexaDocPassword
		New-FlexaDocPassword
		Remove-FlexaDocPassword
		Get-FlexaDocActivityLogs
		Set-FlexaDocAssetLayout
		Get-FlexaDocCard
		New-FlexaDocCompany
		Remove-FlexaDocArticle
		Remove-FlexaDocAsset
		Remove-FlexaDocPassword
		Remove-FlexaDocWebsite
		Set-FlexaDocArticleArchive
		Set-FlexaDocAssetArchive
		Set-FlexaDocAssetLayout
		Set-FlexaDocCompany
		Set-FlexaDocCompanyArchive
		Set-FlexaDocPasswordArchive
		Set-FlexaDocWebsite
		Get-FlexaDocAppInfo
		Get-FlexaDocExpirations

## Usage
After installing the module you will need to get an api key from https://your.flexadoc.domain/admin/api_keys

    New-FlexaDocAPIKey "YourKey"

    New-FlexaDocBaseURL "https://your.flexadoc.domain"
 
    Get-FlexaDocAssets -name "Computer-01" -id 1 -assetlayoutid 1 -companyid 1 
    
    New-FlexaDocAsset -name "Computer-01 - Backup Plan 1" -company_id 10 -asset_layout_id 2 -fields $fields
    $fields = @(
		@{
			plan_name = "Backup Plan1"
		},
		@{
			computer_name = "Computer-01"
		})
    
    Set-FlexaDocAsset -name "Computer-01 - Backup Plan 1" -company_id 10 -asset_layout_id 2 -fields $fields -asset_id 100
 
    Get-FlexaDocCompanies -name "Example Co" -phonenumber "0123456789" -website "https://example.com" -city "Town" -state "State" -id_in_integration "1234"
 
    Get-FlexaDocAssetLayouts -name "People" -layoutid 1
    
    New-FlexaDocAssetLayout -name "People" -icon "fas fa-retweet" -color "#fe9620" -icon_color "#ffffff" -include_passwords $false -include_photos $false -include_comments $false -include_files $false -fields $fields
    $fields = @(
		@{
			label = 'Plan Name'
			field_type = 'Text'
			position = 1
		},
		@{
			label = 'Computer Name'
			field_type = 'Text'
			position = 2
		})
	
 
    Get-FlexaDocAssetLayoutFieldID -name "Plan Name" -asset_layout_id 2
 	
    Get-FlexaDocWebsites -name "https://example.com" -websiteid 1
 
    New-FlexaDocWebsite -name "https://example.com" -companyid 1 -notes "Main website" -paused "false" -disabledns "false" -disablessl "false" -disablewhois "false" 

name and companyid are manditory for New-FlexaDocWebsite

    Set-FlexaDocMagicDash -title "My Dash" -company_name "Example Company" -message "Example message" -icon "fas fa-circle" -image_url "https://example.com/example.png" -content_link "https://example.com" -content "<p> This can be html or text and reveals when clicked</p>" -shade "success"

title, message and company_name are mandatory. You can only use one of icon or image_url. You can only use one of content_link or content

    Remove-FlexaDocMagicDash -title "My Dash" -company_name "Example Company" -id 1

You can either user id or you can use title and company_name together


    Get-FlexaDocArticles -name "Test" -id 10 -company_id 20
    
    New-FlexaDocArticle -name "Test" -content "<p>Html content of article</p>" -folder_id 100 -company_id 20
Name and Content are mandatory, folder_id and company_id are optional. Setting no company ID adds to the global KB
    
    Set-FlexaDocArticle -name "Test" -content "<p>Html content of article</p>" -folder_id 100 -company_id 20 -article_id 10
