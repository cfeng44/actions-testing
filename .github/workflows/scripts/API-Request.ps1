# ---------------------------------------------------------
#   File:         API-Request.ps1
#   Author:       Codey Funston [s222250824@deakin.edu.au]
# 
#   Description:  Does an HTTP POST request to Azure
#                 DevOps API. Uses task creation subset of
#                 the API.
#
# --------------------------------------------------------- 

param (
    [string]$User
)

Write-Host $User
 
# URI Params
$ORG =        "redbackoperations"
$PROJECT =    "Cybersecurity"
$TEAM =       "SecDevOps"
$API_VER =    "api-version=7.1"
$NOTIF =      "suppressNotifications={true}"
$TYPE =       "task"

$PR_TITLE = $env:PR_TITLE
$LINK = $env:LINK
$TASK_DESC = $env:TASK_DESC
$AREA_PATH =  "Cybersecurity\\SecDevOps Team\\Pull Requests"
$TAG =        "PR"
$PAT_TOKEN = $env:PAT_TOKEN

$body = @"
[
    {
        "op": "add",
        "path": "/fields/System.Title",
        "value": "$PR_TITLE"
    },
    {
        "op": "add",
        "path": "/fields/System.AssignedTo",
        "value": "$User"
    },
    {
        "op": "add",
        "path": "/fields/System.Description",
        "value": "$TASK_DESC"
    },
    {
        "op": "add",
        "path": "/fields/System.AreaPath",
        "value": "$AREA_PATH"
    }
]
"@

$headers = @{
    "Authorization" = "Bearer $PAT_TOKEN"
}

Invoke-RestMethod -Uri "https://dev.azure.com/$ORG/$PROJECT/_apis/wit/workitems/`$$($TYPE)?$API_VER" `
                -Method Post `
                -Headers $headers `
                -Body $body `
                -ContentType "application/json-patch+json"
