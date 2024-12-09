# ---------------------------------------------------------
#   File:         Select-Reviewer.ps1
#   Author:       Codey Funston [s222250824@deakin.edu.au]
# 
#   Description:  Based on repository preferences, selects 
#                 a reviewer, or whole team if no matches.
#
# ---------------------------------------------------------

# Cross references current repositoy with team member preferences to produce a
# a list of valid reviewers.

param (
    [string]$Path
)

function Select-Reviewer {
    param (
        [string]$Path
    )

    $team = @()
    $thisRepo = $env:REPO
    $preferences = Get-Content -Raw $path | ConvertFrom-Json -AsHashtable

    foreach ($member in $preferences.Keys) {
        if ($preferences[$member] -eq $thisRepo) {
            $team += $member
        }
    }

    if ($team.Count -eq 0) {
        $team = $prefences.Keys

    return $team
    }
}

if ($MyInvocation.InvocationName -eq $PSCommandPath) {
    $result = Select-Reviewer -Path $Path
    Write-Output $result
}

