# ---------------------------------------------------------
#   File:         API-Request.ps1
#   Author:       Codey Funston [s222250824@deakin.edu.au]
# 
#   Description:  Does an HTTP POST request to Azure
#                 DevOps API. Uses task creation subset of
#                 the API.
#
# --------------------------------------------------------- 
 
# URI Params
$ORG =        "redbackoperations"
$PROJECT =    "Cybersecurity"
$TEAM =       "SecDevOps"
$API_VER =    "api-version=7.1"
$NOTIF =      "suppressNotifications={true}"
$TYPE =       "task"

$USER =       "s222250824@deakin.edu.au"
$PR_TITLE = $env:PR_TITLE
$LINK = $env:LINK
$TASK_DESC = $env:TASK_DESC
$AREA_PATH =  "Cybersecurity\SecDevOps Team\Pull Requests"
$TAG =        "PR"
$PAT_TOKEN = $env:PAT_TOKEN

$body = @"
[
    {
        "op": "add",
        "path": "/fields/System.Title",
        "from": null,
        "value": "$PR_TITLE"
    },
    {
        "op": "add",
        "path": "/fields/System.AssignedTo",
        "from": null,
        "value": "$USER"
    },
    {
        "op": "add",
        "path": "/fields/System.Description",
        "from": null,
        "value": "$TASK_DESC"
    },
    {
        "op": "add",
        "path": "/fields/System.Tag",
        "from": null,
        "value": "$TAG"
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
