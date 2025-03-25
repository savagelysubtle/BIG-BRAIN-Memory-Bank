# BIG-Rules.ps1
# Implementation of the BIG BRAIN Memory Bank rule management system
# Version 1.0.0
# Created: 2025-03-28

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("list", "add", "update", "remove", "apply", "validate")]
    [string]$Command,

    [Parameter()]
    [string]$RuleId,

    [Parameter()]
    [string]$Category,

    [Parameter()]
    [string]$Description,

    [Parameter()]
    [string]$Pattern,

    [Parameter()]
    [string]$Action,

    [Parameter()]
    [int]$Priority = 100,

    [Parameter()]
    [string]$TargetPath = ".\memory-bank",

    [Parameter()]
    [switch]$Force,

    [Parameter()]
    [switch]$Detailed
)

#-----------------------------------------------------------
# Import logging utility
#-----------------------------------------------------------
$utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "../Utilities/Write-BIGLog.ps1"
. $utilityPath

# Start logging
$logFile = Start-BIGLogging -ScriptName $MyInvocation.MyCommand.Path

#-----------------------------------------------------------
# Set up paths and create directories if needed
#-----------------------------------------------------------
$rulesDir = Join-Path -Path (Split-Path -Parent $PSScriptRoot) -ChildPath "Rules"
$rulesFile = Join-Path -Path $rulesDir -ChildPath "memory-rules.json"

if (-not (Test-Path -Path $rulesDir)) {
    try {
        New-Item -Path $rulesDir -ItemType Directory -Force | Out-Null
        Write-BIGLog -Message "Created rules directory at $rulesDir" -Level "INFO" -LogFile $logFile
    }
    catch {
        Write-BIGLog -Message "Failed to create rules directory: $_" -Level "ERROR" -LogFile $logFile
        exit 1
    }
}

#-----------------------------------------------------------
# Helper functions
#-----------------------------------------------------------

# Load existing rules or create a default ruleset
function Get-Rules {
    if (Test-Path -Path $rulesFile) {
        try {
            $rules = Get-Content -Path $rulesFile -Raw | ConvertFrom-Json
            return $rules
        }
        catch {
            Write-BIGLog -Message "Failed to load rules file: $_" -Level "ERROR" -LogFile $logFile
            $null = Read-Host "Press Enter to continue"
            exit 1
        }
    }
    else {
        # Create default rules structure
        $defaultRules = @{
            "metadata" = @{
                "version"     = "1.0"
                "lastUpdated" = (Get-Date -Format "yyyy-MM-dd")
            }
            "rules"    = @(
                @{
                    "id"          = "core-001"
                    "category"    = "organization"
                    "description" = "Stable knowledge should be moved to long-term memory"
                    "pattern"     = "*.md"
                    "action"      = "move-to-long-term"
                    "priority"    = 100
                    "enabled"     = $true
                },
                @{
                    "id"          = "core-002"
                    "category"    = "categorization"
                    "description" = "Session records should be categorized as episodic memory"
                    "pattern"     = "*session*.md"
                    "action"      = "categorize-as-episodic"
                    "priority"    = 90
                    "enabled"     = $true
                },
                @{
                    "id"          = "core-003"
                    "category"    = "naming"
                    "description" = "All files should use kebab-case naming convention"
                    "pattern"     = "*"
                    "action"      = "enforce-kebab-case"
                    "priority"    = 80
                    "enabled"     = $true
                }
            )
        }

        try {
            $defaultRules | ConvertTo-Json -Depth 5 | Set-Content -Path $rulesFile
            Write-BIGLog -Message "Created default rules file at $rulesFile" -Level "INFO" -LogFile $logFile
            return $defaultRules
        }
        catch {
            Write-BIGLog -Message "Failed to create default rules file: $_" -Level "ERROR" -LogFile $logFile
            $null = Read-Host "Press Enter to continue"
            exit 1
        }
    }
}

# Save rules to file
function Save-Rules {
    param (
        [PSCustomObject]$Rules
    )

    # Update metadata
    $Rules.metadata.lastUpdated = Get-Date -Format "yyyy-MM-dd"

    try {
        $Rules | ConvertTo-Json -Depth 5 | Set-Content -Path $rulesFile
        Write-BIGLog -Message "Rules saved to $rulesFile" -Level "INFO" -LogFile $logFile
        return $true
    }
    catch {
        Write-BIGLog -Message "Failed to save rules: $_" -Level "ERROR" -LogFile $logFile
        return $false
    }
}

# Display a rule's details
function Show-RuleDetails {
    param (
        [PSCustomObject]$Rule
    )

    Write-Host ""
    Write-Host "Rule ID:      " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.id

    Write-Host "Category:     " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.category

    Write-Host "Description:  " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.description

    Write-Host "Pattern:      " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.pattern

    Write-Host "Action:       " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.action

    Write-Host "Priority:     " -ForegroundColor Cyan -NoNewline
    Write-Host $Rule.priority

    Write-Host "Enabled:      " -ForegroundColor Cyan -NoNewline
    if ($Rule.enabled) {
        Write-Host "Yes" -ForegroundColor Green
    }
    else {
        Write-Host "No" -ForegroundColor Red
    }
    Write-Host ""
}

# Validate Rule ID format (prefix-###)
function Test-RuleIdFormat {
    param (
        [string]$Id
    )

    return $Id -match '^[a-z]+-\d{3}$'
}

#-----------------------------------------------------------
# Command implementations
#-----------------------------------------------------------

# Command: list - List all rules or filter by category
function Invoke-ListCommand {
    $rules = Get-Rules

    if ($rules.rules.Count -eq 0) {
        Write-Host "No rules found." -ForegroundColor Yellow
        return
    }

    # If category specified, filter by it
    $filteredRules = $rules.rules
    if ($Category) {
        $filteredRules = $filteredRules | Where-Object { $_.category -eq $Category }

        if ($filteredRules.Count -eq 0) {
            Write-Host "No rules found in category '$Category'." -ForegroundColor Yellow
            return
        }
    }

    # Sort rules by priority (descending) and then by ID
    $sortedRules = $filteredRules | Sort-Object -Property @{Expression = "priority"; Descending = $true }, @{Expression = "id"; Descending = $false }

    # Display rules
    Write-BIGHeader -Title "MEMORY BANK RULES" -FgColor Cyan -LogFile $logFile

    if ($Category) {
        Write-Host "Showing rules in category: " -NoNewline
        Write-Host "$Category" -ForegroundColor Cyan
    }

    Write-Host "Total rules: $($sortedRules.Count)" -ForegroundColor Cyan
    Write-Host ""

    if ($Detailed) {
        foreach ($rule in $sortedRules) {
            Show-RuleDetails -Rule $rule
        }
    }
    else {
        # Create a table format
        $table = @()
        foreach ($rule in $sortedRules) {
            $status = if ($rule.enabled) { "Enabled" } else { "Disabled" }
            $row = [PSCustomObject]@{
                "ID"       = $rule.id
                "Category" = $rule.category
                "Priority" = $rule.priority
                "Action"   = $rule.action
                "Status"   = $status
            }
            $table += $row
        }

        $table | Format-Table -AutoSize
        Write-Host "Use -Detailed to see full rule information." -ForegroundColor Gray
    }
}

# Command: add - Add a new rule
function Invoke-AddCommand {
    if (-not $RuleId) {
        Write-BIGLog -Message "Rule ID is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rule ID is required" -ForegroundColor Red
        return
    }

    if (-not (Test-RuleIdFormat -Id $RuleId)) {
        Write-BIGLog -Message "Invalid rule ID format: $RuleId" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Invalid rule ID format. Must be in format 'prefix-###' (e.g., 'org-001')" -ForegroundColor Red
        return
    }

    if (-not $Category) {
        Write-BIGLog -Message "Category is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Category is required" -ForegroundColor Red
        return
    }

    if (-not $Description) {
        Write-BIGLog -Message "Description is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Description is required" -ForegroundColor Red
        return
    }

    if (-not $Pattern) {
        Write-BIGLog -Message "Pattern is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Pattern is required" -ForegroundColor Red
        return
    }

    if (-not $Action) {
        Write-BIGLog -Message "Action is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Action is required" -ForegroundColor Red
        return
    }

    $rules = Get-Rules

    # Check if rule ID already exists
    $existingRule = $rules.rules | Where-Object { $_.id -eq $RuleId }
    if ($existingRule -and -not $Force) {
        Write-BIGLog -Message "Rule ID already exists: $RuleId" -Level "WARNING" -LogFile $logFile
        Write-Host "Rule ID already exists. Use -Force to overwrite." -ForegroundColor Yellow
        return
    }

    # Create new rule
    $newRule = @{
        "id"          = $RuleId
        "category"    = $Category
        "description" = $Description
        "pattern"     = $Pattern
        "action"      = $Action
        "priority"    = $Priority
        "enabled"     = $true
    }

    # Remove existing rule if it exists
    if ($existingRule) {
        $rules.rules = @($rules.rules | Where-Object { $_.id -ne $RuleId })
    }

    # Add new rule
    $rules.rules += $newRule

    # Save changes
    if (Save-Rules -Rules $rules) {
        Write-BIGLog -Message "Rule added: $RuleId" -Level "SUCCESS" -LogFile $logFile
        Write-Host "Rule added successfully." -ForegroundColor Green
        Show-RuleDetails -Rule ([PSCustomObject]$newRule)
    }
}

# Command: update - Update an existing rule
function Invoke-UpdateCommand {
    if (-not $RuleId) {
        Write-BIGLog -Message "Rule ID is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rule ID is required" -ForegroundColor Red
        return
    }

    $rules = Get-Rules

    # Find the rule to update
    $ruleIndex = -1
    for ($i = 0; $i -lt $rules.rules.Count; $i++) {
        if ($rules.rules[$i].id -eq $RuleId) {
            $ruleIndex = $i
            break
        }
    }

    if ($ruleIndex -eq -1) {
        Write-BIGLog -Message "Rule not found: $RuleId" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rule not found: $RuleId" -ForegroundColor Red
        return
    }

    # Update rule properties if provided
    if ($Category) {
        $rules.rules[$ruleIndex].category = $Category
    }

    if ($Description) {
        $rules.rules[$ruleIndex].description = $Description
    }

    if ($Pattern) {
        $rules.rules[$ruleIndex].pattern = $Pattern
    }

    if ($Action) {
        $rules.rules[$ruleIndex].action = $Action
    }

    if ($PSBoundParameters.ContainsKey('Priority')) {
        $rules.rules[$ruleIndex].priority = $Priority
    }

    # Save changes
    if (Save-Rules -Rules $rules) {
        Write-BIGLog -Message "Rule updated: $RuleId" -Level "SUCCESS" -LogFile $logFile
        Write-Host "Rule updated successfully." -ForegroundColor Green
        Show-RuleDetails -Rule $rules.rules[$ruleIndex]
    }
}

# Command: remove - Remove a rule
function Invoke-RemoveCommand {
    if (-not $RuleId) {
        Write-BIGLog -Message "Rule ID is required" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rule ID is required" -ForegroundColor Red
        return
    }

    $rules = Get-Rules

    # Find the rule to remove
    $rule = $rules.rules | Where-Object { $_.id -eq $RuleId }
    if (-not $rule) {
        Write-BIGLog -Message "Rule not found: $RuleId" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rule not found: $RuleId" -ForegroundColor Red
        return
    }

    # Confirm removal if -Force not specified
    if (-not $Force) {
        Show-RuleDetails -Rule $rule
        $confirmation = Read-Host "Are you sure you want to remove this rule? (y/n)"
        if ($confirmation -ne 'y') {
            Write-BIGLog -Message "Rule removal cancelled" -Level "INFO" -LogFile $logFile
            Write-Host "Rule removal cancelled." -ForegroundColor Yellow
            return
        }
    }

    # Remove the rule
    $rules.rules = @($rules.rules | Where-Object { $_.id -ne $RuleId })

    # Save changes
    if (Save-Rules -Rules $rules) {
        Write-BIGLog -Message "Rule removed: $RuleId" -Level "SUCCESS" -LogFile $logFile
        Write-Host "Rule removed successfully." -ForegroundColor Green
    }
}

# Command: apply - Apply rules to the target path
function Invoke-ApplyCommand {
    $rules = Get-Rules

    if ($rules.rules.Count -eq 0) {
        Write-BIGLog -Message "No rules to apply" -Level "WARNING" -LogFile $logFile
        Write-Host "No rules to apply." -ForegroundColor Yellow
        return
    }

    # Validate target path
    if (-not (Test-Path -Path $TargetPath)) {
        Write-BIGLog -Message "Target path not found: $TargetPath" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Target path not found: $TargetPath" -ForegroundColor Red
        return
    }

    Write-BIGHeader -Title "APPLYING MEMORY BANK RULES" -LogFile $logFile
    Write-Host "Target: " -NoNewline
    Write-Host $TargetPath -ForegroundColor Cyan
    Write-Host "Rules: " -NoNewline
    Write-Host "$($rules.rules.Count) available" -ForegroundColor Cyan

    # Sort rules by priority (descending)
    $sortedRules = $rules.rules | Where-Object { $_.enabled } | Sort-Object -Property @{Expression = "priority"; Descending = $true }
    Write-Host "Active rules: $($sortedRules.Count)" -ForegroundColor Cyan
    Write-Host ""

    # Apply each rule
    $appliedCount = 0
    foreach ($rule in $sortedRules) {
        Write-Host "Applying rule: " -NoNewline
        Write-Host "$($rule.id)" -ForegroundColor Cyan -NoNewline
        Write-Host " - $($rule.description)"

        # Get matching files
        $matchingFiles = Get-ChildItem -Path $TargetPath -Recurse -File | Where-Object { $_.Name -like $rule.pattern }
        Write-Host "  Matched files: $($matchingFiles.Count)" -ForegroundColor Gray

        # Skip if no matches
        if ($matchingFiles.Count -eq 0) {
            Write-Host "  No matching files - skipping" -ForegroundColor Yellow
            continue
        }

        # Apply action to matching files
        $successCount = 0
        foreach ($file in $matchingFiles) {
            try {
                # Placeholder for actual rule implementation - would vary by action type
                switch ($rule.action) {
                    "move-to-long-term" {
                        Write-Host "  [Simulated] Moving $($file.Name) to long-term memory" -ForegroundColor DarkGray
                        # Actual implementation would move files to the long-term memory location
                        $successCount++
                    }
                    "categorize-as-episodic" {
                        Write-Host "  [Simulated] Categorizing $($file.Name) as episodic memory" -ForegroundColor DarkGray
                        # Actual implementation would update file metadata or move to episodic memory location
                        $successCount++
                    }
                    "enforce-kebab-case" {
                        Write-Host "  [Simulated] Ensuring $($file.Name) uses kebab-case" -ForegroundColor DarkGray
                        # Actual implementation would rename files to kebab-case
                        $successCount++
                    }
                    default {
                        Write-Host "  Unsupported action: $($rule.action)" -ForegroundColor Yellow
                    }
                }
            }
            catch {
                Write-BIGLog -Message "Error applying rule $($rule.id) to $($file.FullName): $_" -Level "ERROR" -LogFile $logFile
                Write-Host "  Error processing $($file.Name): $_" -ForegroundColor Red
            }
        }

        if ($successCount -gt 0) {
            Write-Host "  Successfully applied to $successCount files" -ForegroundColor Green
            $appliedCount++
        }

        Write-Host ""
    }

    if ($appliedCount -gt 0) {
        Write-BIGLog -Message "Applied $appliedCount rules to $TargetPath" -Level "SUCCESS" -LogFile $logFile
        Write-Host "Rule application complete. Applied $appliedCount rules." -ForegroundColor Green
    }
    else {
        Write-BIGLog -Message "No rules were applied to $TargetPath" -Level "WARNING" -LogFile $logFile
        Write-Host "No rules were applied." -ForegroundColor Yellow
    }
}

# Command: validate - Validate the consistency of rules
function Invoke-ValidateCommand {
    $rules = Get-Rules

    Write-BIGHeader -Title "VALIDATING MEMORY BANK RULES" -LogFile $logFile

    if ($rules.rules.Count -eq 0) {
        Write-BIGLog -Message "No rules to validate" -Level "WARNING" -LogFile $logFile
        Write-Host "No rules to validate." -ForegroundColor Yellow
        return
    }

    $errorCount = 0
    $warningCount = 0

    # Check for duplicate rule IDs
    $ruleIds = $rules.rules | Select-Object -ExpandProperty id
    $duplicateIds = $ruleIds | Group-Object | Where-Object { $_.Count -gt 1 } | Select-Object -ExpandProperty Name

    if ($duplicateIds.Count -gt 0) {
        foreach ($id in $duplicateIds) {
            Write-BIGLog -Message "Duplicate rule ID: $id" -Level "ERROR" -LogFile $logFile
            Write-Host "Error: Duplicate rule ID: $id" -ForegroundColor Red
        }
        $errorCount += $duplicateIds.Count
    }

    # Check for invalid rule ID format
    foreach ($rule in $rules.rules) {
        if (-not (Test-RuleIdFormat -Id $rule.id)) {
            Write-BIGLog -Message "Invalid rule ID format: $($rule.id)" -Level "ERROR" -LogFile $logFile
            Write-Host "Error: Invalid rule ID format: $($rule.id)" -ForegroundColor Red
            $errorCount++
        }
    }

    # Check for missing required fields
    foreach ($rule in $rules.rules) {
        $missingFields = @()

        if (-not $rule.category) { $missingFields += "category" }
        if (-not $rule.description) { $missingFields += "description" }
        if (-not $rule.pattern) { $missingFields += "pattern" }
        if (-not $rule.action) { $missingFields += "action" }

        if ($missingFields.Count -gt 0) {
            Write-BIGLog -Message "Rule $($rule.id) is missing required fields: $($missingFields -join ', ')" -Level "ERROR" -LogFile $logFile
            Write-Host "Error: Rule $($rule.id) is missing required fields: $($missingFields -join ', ')" -ForegroundColor Red
            $errorCount++
        }
    }

    # Check for potential conflicts (rules with same pattern and action but different priorities)
    $patternActionGroups = $rules.rules | Group-Object -Property pattern, action
    foreach ($group in $patternActionGroups) {
        if ($group.Count -gt 1) {
            $ruleList = $group.Group.id -join ', '
            Write-BIGLog -Message "Potential conflict: Rules with same pattern and action but different priorities: $ruleList" -Level "WARNING" -LogFile $logFile
            Write-Host "Warning: Potential conflict between rules: $ruleList" -ForegroundColor Yellow
            Write-Host "         These rules have the same pattern and action but different priorities." -ForegroundColor Yellow
            $warningCount++
        }
    }

    # Display validation summary
    Write-Host ""
    Write-Host "Validation complete:" -ForegroundColor Cyan
    Write-Host "  Total rules: $($rules.rules.Count)" -ForegroundColor Cyan
    Write-Host "  Errors: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
    Write-Host "  Warnings: $warningCount" -ForegroundColor $(if ($warningCount -gt 0) { "Yellow" } else { "Green" })

    if ($errorCount -eq 0 -and $warningCount -eq 0) {
        Write-BIGLog -Message "Rules validation passed with no issues" -Level "SUCCESS" -LogFile $logFile
        Write-Host "All rules are valid!" -ForegroundColor Green
    }
    elseif ($errorCount -eq 0) {
        Write-BIGLog -Message "Rules validation passed with $warningCount warnings" -Level "WARNING" -LogFile $logFile
        Write-Host "Rules are valid but have warnings to review." -ForegroundColor Yellow
    }
    else {
        Write-BIGLog -Message "Rules validation failed with $errorCount errors and $warningCount warnings" -Level "ERROR" -LogFile $logFile
        Write-Host "Rule validation failed. Please fix the errors and try again." -ForegroundColor Red
    }
}

#-----------------------------------------------------------
# Execute the specified command
#-----------------------------------------------------------
Write-BIGHeader -Title "BIG RULES COMMAND: $Command" -LogFile $logFile

switch ($Command) {
    "list" {
        Invoke-ListCommand
    }
    "add" {
        Invoke-AddCommand
    }
    "update" {
        Invoke-UpdateCommand
    }
    "remove" {
        Invoke-RemoveCommand
    }
    "apply" {
        Invoke-ApplyCommand
    }
    "validate" {
        Invoke-ValidateCommand
    }
    default {
        Write-BIGLog -Message "Invalid command: $Command" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Invalid command: $Command" -ForegroundColor Red
    }
}

# End logging
Stop-BIGLogging -ScriptName $MyInvocation.MyCommand.Path -LogFile $logFile