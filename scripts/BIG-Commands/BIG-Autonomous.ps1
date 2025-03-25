# BIG-Autonomous.ps1
# Implementation of the BIG BRAIN Memory Bank autonomous operations
# Version 1.2.0
# Created: 2025-03-28
# Updated: 2025-03-29 - Fixed parameter handling and invocation
# Updated: 2025-03-29 - Fixed command parameter passing

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromRemainingArguments = $true)]
    [ValidateSet("daily", "weekly", "monthly", "refresh", "full")]
    [string]$Command,

    [Parameter()]
    [string]$OutputPath,

    [Parameter()]
    [switch]$SkipHealthCheck,

    [Parameter()]
    [switch]$SkipReorganize,

    [Parameter()]
    [switch]$SkipRules,

    [Parameter()]
    [switch]$SkipReports,

    [Parameter()]
    [switch]$SkipUpdate,

    [Parameter()]
    [switch]$NoInteraction
)

Write-Host "BIG-Autonomous running with command: $Command" -ForegroundColor Cyan

#-----------------------------------------------------------
# Import logging utility
#-----------------------------------------------------------
$utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "../Utilities/Write-BIGLog.ps1"
. $utilityPath

# Start logging
$logFile = Start-BIGLogging -ScriptName $MyInvocation.MyCommand.Path

#-----------------------------------------------------------
# Set up paths to command scripts
#-----------------------------------------------------------
$scriptsDir = $PSScriptRoot
$mainScript = Join-Path -Path $scriptsDir -ChildPath "BIG.ps1"

# Default reports directory
$reportsDir = Join-Path -Path (Split-Path -Parent $scriptsDir) -ChildPath "scripts/reports"
if (-not [string]::IsNullOrEmpty($OutputPath)) {
    $reportsDir = $OutputPath
}

# Create reports directory if it doesn't exist
if (-not (Test-Path -Path $reportsDir)) {
    try {
        New-Item -Path $reportsDir -ItemType Directory -Force | Out-Null
        Write-BIGLog -Message "Created reports directory at $reportsDir" -Level "INFO" -LogFile $logFile
    }
    catch {
        Write-BIGLog -Message "Failed to create reports directory: $_" -Level "ERROR" -LogFile $logFile
        exit 1
    }
}

#-----------------------------------------------------------
# Helper functions
#-----------------------------------------------------------

# Function to execute a BIG command
function Invoke-BIGCommand {
    [CmdletBinding()]
    param (
        [string]$Category,
        [string]$Command,
        [string[]]$Parameters,
        [string]$Description,
        [switch]$Critical
    )

    Write-BIGLog -Message "Executing: $Category $Command $Parameters" -Level "INFO" -LogFile $logFile

    if ($Description) {
        Write-Host "`n$Description..." -ForegroundColor Cyan
    }

    try {
        # Use positional parameters: BIG.ps1 category command [parameters]
        $argList = @($Category, $Command)

        if ($Parameters -and $Parameters.Count -gt 0) {
            $argList += $Parameters
        }

        # Execute BIG.ps1 with arguments
        & $mainScript @argList
        $exitCode = $LASTEXITCODE

        if ($exitCode -eq 0 -or $exitCode -eq $null) {
            Write-BIGLog -Message "$Category $Command completed successfully" -Level "SUCCESS" -LogFile $logFile
            return $true
        }
        else {
            Write-BIGLog -Message "$Category $Command failed with exit code $exitCode" -Level "ERROR" -LogFile $logFile

            if ($Critical) {
                Write-Host "Critical operation failed. Aborting sequence." -ForegroundColor Red
                return $false
            }
            else {
                Write-Host "Operation failed but continuing with sequence." -ForegroundColor Yellow
                return $true
            }
        }
    }
    catch {
        $errorMessage = $_
        Write-BIGLog -Message ("Error executing {0} {1}: {2}" -f $Category, $Command, $errorMessage) -Level "ERROR" -LogFile $logFile

        if ($Critical) {
            Write-Host ("Critical operation failed with error: {0}" -f $errorMessage) -ForegroundColor Red
            Write-Host "Aborting sequence." -ForegroundColor Red
            return $false
        }
        else {
            Write-Host ("Operation failed with error: {0}" -f $errorMessage) -ForegroundColor Yellow
            Write-Host "Continuing with sequence." -ForegroundColor Yellow
            return $true
        }
    }
}

# Function to prompt for continuation
function Confirm-Continue {
    param (
        [string]$Message = "Continue with the next operation?"
    )

    if ($NoInteraction) {
        return $true
    }

    $response = Read-Host "$Message (Y/n)"
    return ($response -eq "" -or $response -eq "y" -or $response -eq "Y")
}

#-----------------------------------------------------------
# Command implementations
#-----------------------------------------------------------

# Command: daily - Daily operations for the memory bank
function Invoke-DailyOperations {
    Write-BIGHeader -Title "DAILY AUTONOMOUS OPERATIONS" -LogFile $logFile

    # Step 1: Health check
    if (-not $SkipHealthCheck) {
        $healthSuccess = Invoke-BIGCommand -Category "analytics" -Command "health" -Description "Running health check"
        if (-not $healthSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Daily operations sequence aborted after health check" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 2: Apply rules
    if (-not $SkipRules) {
        $rulesSuccess = Invoke-BIGCommand -Category "rules" -Command "apply" -Description "Applying memory rules"
        if (-not $rulesSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Daily operations sequence aborted after applying rules" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 3: Organize content
    if (-not $SkipReorganize) {
        $organizeSuccess = Invoke-BIGCommand -Category "organization" -Command "reorganize" -Description "Reorganizing memory content"
        if (-not $organizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Daily operations sequence aborted after reorganizing content" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 4: Create daily summary
    $today = Get-Date -Format "yyyy-MM-dd"
    $reportParams = @("-Format", "JSON", "-OutputPath", "$reportsDir/daily-summary-$today.json")
    $reportSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $reportParams -Description "Generating daily summary report"

    Write-BIGLog -Message "Daily operations completed successfully" -Level "SUCCESS" -LogFile $logFile
    Write-Host "`nDaily operations completed successfully." -ForegroundColor Green
    Write-Host "Daily summary saved to: $reportsDir/daily-summary-$today.json" -ForegroundColor Green
}

# Command: weekly - Weekly maintenance operations
function Invoke-WeeklyOperations {
    Write-BIGHeader -Title "WEEKLY AUTONOMOUS OPERATIONS" -LogFile $logFile

    # Step 1: Update system
    if (-not $SkipUpdate) {
        $updateSuccess = Invoke-BIGCommand -Category "update" -Command "system" -Critical -Description "Updating system scripts"
        if (-not $updateSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Weekly operations sequence aborted after system update" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 2: Validate rules
    if (-not $SkipRules) {
        $validateSuccess = Invoke-BIGCommand -Category "rules" -Command "validate" -Description "Validating memory rules"
        if (-not $validateSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Weekly operations sequence aborted after validating rules" -Level "WARNING" -LogFile $logFile
            return
        }

        $applyRulesSuccess = Invoke-BIGCommand -Category "rules" -Command "apply" -Description "Applying memory rules"
        if (-not $applyRulesSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Weekly operations sequence aborted after applying rules" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 3: Comprehensive reorganization
    if (-not $SkipReorganize) {
        $reorganizeSuccess = Invoke-BIGCommand -Category "organization" -Command "reorganize" -Description "Reorganizing memory content"
        if (-not $reorganizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Weekly operations sequence aborted after reorganizing content" -Level "WARNING" -LogFile $logFile
            return
        }

        $cleanupSuccess = Invoke-BIGCommand -Category "organization" -Command "cleanup" -Description "Cleaning up obsolete files"
        if (-not $cleanupSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Weekly operations sequence aborted after cleanup" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 4: Generate comprehensive reports
    if (-not $SkipReports) {
        $weekly = Get-Date -Format "yyyy-MM-dd"

        # Generate HTML report
        $htmlParams = @("-Format", "HTML", "-IncludeDetails", "-OutputPath", "$reportsDir/weekly-report-$weekly.html")
        $htmlSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $htmlParams -Description "Generating HTML report"

        # Generate stats export
        $statsParams = @("-IncludeDetails", "-ExportJson", "-OutputPath", "$reportsDir/weekly-stats-$weekly.json")
        $statsSuccess = Invoke-BIGCommand -Category "analytics" -Command "stats" -Parameters $statsParams -Description "Exporting detailed statistics"
    }

    Write-BIGLog -Message "Weekly operations completed successfully" -Level "SUCCESS" -LogFile $logFile
    Write-Host "`nWeekly operations completed successfully." -ForegroundColor Green
    if (-not $SkipReports) {
        $weekly = Get-Date -Format "yyyy-MM-dd"
        Write-Host "Weekly report saved to: $reportsDir/weekly-report-$weekly.html" -ForegroundColor Green
        Write-Host "Weekly statistics saved to: $reportsDir/weekly-stats-$weekly.json" -ForegroundColor Green
    }
}

# Command: monthly - Monthly comprehensive maintenance
function Invoke-MonthlyOperations {
    Write-BIGHeader -Title "MONTHLY AUTONOMOUS OPERATIONS" -LogFile $logFile

    # Step 1: Update scripts and memory bank structure
    if (-not $SkipUpdate) {
        $updateScriptsSuccess = Invoke-BIGCommand -Category "update" -Command "scripts" -Critical -Description "Updating initialization scripts"
        if (-not $updateScriptsSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after updating scripts" -Level "WARNING" -LogFile $logFile
            return
        }

        $updateMemorySuccess = Invoke-BIGCommand -Category "update" -Command "memory" -Critical -Description "Updating memory bank structure"
        if (-not $updateMemorySuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after updating memory structure" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 2: Complete rules validation and application
    if (-not $SkipRules) {
        $validateSuccess = Invoke-BIGCommand -Category "rules" -Command "validate" -Description "Validating memory rules"
        if (-not $validateSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after validating rules" -Level "WARNING" -LogFile $logFile
            return
        }

        $applyRulesSuccess = Invoke-BIGCommand -Category "rules" -Command "apply" -Description "Applying memory rules"
        if (-not $applyRulesSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after applying rules" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 3: Complete organization operations
    if (-not $SkipReorganize) {
        $categorizeSuccess = Invoke-BIGCommand -Category "organization" -Command "categorize" -Description "Categorizing memory content"
        if (-not $categorizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after categorizing content" -Level "WARNING" -LogFile $logFile
            return
        }

        $reorganizeSuccess = Invoke-BIGCommand -Category "organization" -Command "reorganize" -Description "Reorganizing memory content"
        if (-not $reorganizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after reorganizing content" -Level "WARNING" -LogFile $logFile
            return
        }

        $cleanupSuccess = Invoke-BIGCommand -Category "organization" -Command "cleanup" -Description "Cleaning up obsolete files"
        if (-not $cleanupSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Monthly operations sequence aborted after cleanup" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 4: Generate comprehensive reports
    if (-not $SkipReports) {
        $monthly = Get-Date -Format "yyyy-MM"

        # Generate HTML report
        $htmlParams = @("-Format", "HTML", "-IncludeDetails", "-OutputPath", "$reportsDir/monthly-report-$monthly.html")
        $htmlSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $htmlParams -Description "Generating HTML report"

        # Generate stats export
        $statsParams = @("-IncludeDetails", "-ExportJson", "-OutputPath", "$reportsDir/monthly-stats-$monthly.json")
        $statsSuccess = Invoke-BIGCommand -Category "analytics" -Command "stats" -Parameters $statsParams -Description "Exporting detailed statistics"

        # Generate text report
        $textParams = @("-Format", "Text", "-OutputPath", "$reportsDir/monthly-report-$monthly.txt")
        $textSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $textParams -Description "Generating text report"
    }

    Write-BIGLog -Message "Monthly operations completed successfully" -Level "SUCCESS" -LogFile $logFile
    Write-Host "`nMonthly operations completed successfully." -ForegroundColor Green
    if (-not $SkipReports) {
        $monthly = Get-Date -Format "yyyy-MM"
        Write-Host "Monthly reports saved to:" -ForegroundColor Green
        Write-Host "  - $reportsDir/monthly-report-$monthly.html" -ForegroundColor Green
        Write-Host "  - $reportsDir/monthly-stats-$monthly.json" -ForegroundColor Green
        Write-Host "  - $reportsDir/monthly-report-$monthly.txt" -ForegroundColor Green
    }
}

# Command: refresh - Quick refresh of the memory bank
function Invoke-RefreshOperations {
    Write-BIGHeader -Title "MEMORY BANK REFRESH OPERATIONS" -LogFile $logFile

    # Step 1: Health check
    if (-not $SkipHealthCheck) {
        $healthSuccess = Invoke-BIGCommand -Category "analytics" -Command "health" -Description "Running health check"
        if (-not $healthSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Refresh operations sequence aborted after health check" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 2: Apply rules
    if (-not $SkipRules) {
        $rulesSuccess = Invoke-BIGCommand -Category "rules" -Command "apply" -Description "Applying memory rules"
        if (-not $rulesSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Refresh operations sequence aborted after applying rules" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 3: Quick reorganize
    if (-not $SkipReorganize) {
        $organizeSuccess = Invoke-BIGCommand -Category "organization" -Command "reorganize" -Description "Reorganizing memory content"
        if (-not $organizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Refresh operations sequence aborted after reorganizing content" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    Write-BIGLog -Message "Refresh operations completed successfully" -Level "SUCCESS" -LogFile $logFile
    Write-Host "`nMemory bank refresh completed successfully." -ForegroundColor Green
}

# Command: full - Complete comprehensive system operations
function Invoke-FullOperations {
    Write-BIGHeader -Title "FULL AUTONOMOUS OPERATIONS" -LogFile $logFile

    # Step 1: Update the entire system
    if (-not $SkipUpdate) {
        $updateSystemSuccess = Invoke-BIGCommand -Category "update" -Command "system" -Critical -Description "Updating the entire system"
        if (-not $updateSystemSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after system update" -Level "WARNING" -LogFile $logFile
            return
        }

        $updateScriptsSuccess = Invoke-BIGCommand -Category "update" -Command "scripts" -Critical -Description "Updating initialization scripts"
        if (-not $updateScriptsSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after updating scripts" -Level "WARNING" -LogFile $logFile
            return
        }

        $updateMemorySuccess = Invoke-BIGCommand -Category "update" -Command "memory" -Critical -Description "Updating memory bank structure"
        if (-not $updateMemorySuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after updating memory structure" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 2: Complete rules validation and application
    if (-not $SkipRules) {
        $validateSuccess = Invoke-BIGCommand -Category "rules" -Command "validate" -Description "Validating memory rules"
        if (-not $validateSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after validating rules" -Level "WARNING" -LogFile $logFile
            return
        }

        $applyRulesSuccess = Invoke-BIGCommand -Category "rules" -Command "apply" -Description "Applying memory rules"
        if (-not $applyRulesSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after applying rules" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 3: Complete health check and analytics
    if (-not $SkipHealthCheck) {
        $healthSuccess = Invoke-BIGCommand -Category "analytics" -Command "health" -Description "Running health check"
        if (-not $healthSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after health check" -Level "WARNING" -LogFile $logFile
            return
        }

        $statsParams = @("-IncludeDetails")
        $statsSuccess = Invoke-BIGCommand -Category "analytics" -Command "stats" -Parameters $statsParams -Description "Gathering detailed statistics"
        if (-not $statsSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after gathering statistics" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 4: Complete organization operations
    if (-not $SkipReorganize) {
        $categorizeSuccess = Invoke-BIGCommand -Category "organization" -Command "categorize" -Description "Categorizing memory content"
        if (-not $categorizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after categorizing content" -Level "WARNING" -LogFile $logFile
            return
        }

        $reorganizeSuccess = Invoke-BIGCommand -Category "organization" -Command "reorganize" -Description "Reorganizing memory content"
        if (-not $reorganizeSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after reorganizing content" -Level "WARNING" -LogFile $logFile
            return
        }

        $cleanupSuccess = Invoke-BIGCommand -Category "organization" -Command "cleanup" -Description "Cleaning up obsolete files"
        if (-not $cleanupSuccess -or -not (Confirm-Continue)) {
            Write-BIGLog -Message "Full operations sequence aborted after cleanup" -Level "WARNING" -LogFile $logFile
            return
        }
    }

    # Step 5: Generate comprehensive reports
    if (-not $SkipReports) {
        $date = Get-Date -Format "yyyy-MM-dd"

        # Generate HTML report
        $htmlParams = @("-Format", "HTML", "-IncludeDetails", "-OutputPath", "$reportsDir/full-report-$date.html")
        $htmlSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $htmlParams -Description "Generating HTML report"

        # Generate JSON report
        $jsonParams = @("-Format", "JSON", "-IncludeDetails", "-OutputPath", "$reportsDir/full-report-$date.json")
        $jsonSuccess = Invoke-BIGCommand -Category "analytics" -Command "report" -Parameters $jsonParams -Description "Generating JSON report"

        # Generate stats export
        $statsParams = @("-IncludeDetails", "-ExportJson", "-OutputPath", "$reportsDir/full-stats-$date.json")
        $statsSuccess = Invoke-BIGCommand -Category "analytics" -Command "stats" -Parameters $statsParams -Description "Exporting detailed statistics"
    }

    # Step 6: Complete bedtime protocol to finalize
    $bedtimeStartSuccess = Invoke-BIGCommand -Category "bedtime" -Command "start" -Description "Starting bedtime protocol"
    if (-not $bedtimeStartSuccess -or -not (Confirm-Continue)) {
        Write-BIGLog -Message "Full operations sequence aborted during bedtime protocol" -Level "WARNING" -LogFile $logFile
        return
    }

    $bedtimeAnalyzeSuccess = Invoke-BIGCommand -Category "bedtime" -Command "analyze" -Description "Analyzing memory activity"
    if (-not $bedtimeAnalyzeSuccess -or -not (Confirm-Continue)) {
        Write-BIGLog -Message "Full operations sequence aborted during bedtime analysis" -Level "WARNING" -LogFile $logFile
        return
    }

    $bedtimeCompleteSuccess = Invoke-BIGCommand -Category "bedtime" -Command "complete" -Description "Completing bedtime protocol"

    Write-BIGLog -Message "Full operations completed successfully" -Level "SUCCESS" -LogFile $logFile
    Write-Host "`nFull system operations completed successfully." -ForegroundColor Green
    if (-not $SkipReports) {
        $date = Get-Date -Format "yyyy-MM-dd"
        Write-Host "Comprehensive reports saved to:" -ForegroundColor Green
        Write-Host "  - $reportsDir/full-report-$date.html" -ForegroundColor Green
        Write-Host "  - $reportsDir/full-report-$date.json" -ForegroundColor Green
        Write-Host "  - $reportsDir/full-stats-$date.json" -ForegroundColor Green
    }
}

#-----------------------------------------------------------
# Execute the specified command
#-----------------------------------------------------------
Write-BIGHeader -Title "BIG AUTONOMOUS COMMAND: $Command" -LogFile $logFile

# Explicitly handle the command with better error capture
try {
    switch ($Command) {
        "daily" {
            Write-Host "Executing daily operations..." -ForegroundColor Cyan
            Invoke-DailyOperations
        }
        "weekly" {
            Write-Host "Executing weekly operations..." -ForegroundColor Cyan
            Invoke-WeeklyOperations
        }
        "monthly" {
            Write-Host "Executing monthly operations..." -ForegroundColor Cyan
            Invoke-MonthlyOperations
        }
        "refresh" {
            Write-Host "Executing refresh operations..." -ForegroundColor Cyan
            Invoke-RefreshOperations
        }
        "full" {
            Write-Host "Executing full operations..." -ForegroundColor Cyan
            Invoke-FullOperations
        }
        default {
            Write-BIGLog -Message "Invalid command: $Command" -Level "ERROR" -LogFile $logFile
            Write-Host "Error: Invalid command: $Command" -ForegroundColor Red
            exit 1
        }
    }

    # If execution gets here, command was successful
    Write-Host "Autonomous command '$Command' completed successfully!" -ForegroundColor Green
    exit 0
}
catch {
    Write-BIGLog -Message "Error executing autonomous command: $_" -Level "ERROR" -LogFile $logFile
    Write-Host "ERROR executing autonomous command. See log for details." -ForegroundColor Red
    exit 1
}

# End logging
Stop-BIGLogging -ScriptName $MyInvocation.MyCommand.Path -LogFile $logFile