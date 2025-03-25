# Write-BIGLog.ps1
# Centralized logging utility for the BIG BRAIN Memory Bank system
# Version 1.0.0
# Created: 2025-03-27

function Write-BIGLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [ValidateSet("INFO", "WARNING", "ERROR", "DEBUG", "SUCCESS")]
        [string]$Level = "INFO",

        [Parameter(Mandatory = $false)]
        [string]$ScriptName = $MyInvocation.ScriptName,

        [Parameter(Mandatory = $false)]
        [string]$LogFile,

        [Parameter(Mandatory = $false)]
        [switch]$NoConsole,

        [Parameter(Mandatory = $false)]
        [switch]$NoTimestamp
    )

    # Map levels to colors
    $levelColors = @{
        "INFO"    = "White"
        "WARNING" = "Yellow"
        "ERROR"   = "Red"
        "DEBUG"   = "Cyan"
        "SUCCESS" = "Green"
    }

    # Set default log file if not provided
    if (-not $LogFile) {
        $projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
        $logsDir = Join-Path -Path $projectRoot -ChildPath "scripts/logs"

        # Create logs directory if it doesn't exist
        if (-not (Test-Path -Path $logsDir)) {
            New-Item -Path $logsDir -ItemType Directory -Force | Out-Null
        }

        $date = Get-Date -Format "yyyy-MM-dd"
        $LogFile = Join-Path -Path $logsDir -ChildPath "BIG-Memory-$date.log"
    }

    # Format the log message
    $scriptNameOnly = Split-Path -Leaf $ScriptName
    $timestamp = if (-not $NoTimestamp) { Get-Date -Format "yyyy-MM-dd HH:mm:ss" } else { "" }
    $formattedMessage = if (-not $NoTimestamp) {
        "[$timestamp] [$Level] [$scriptNameOnly] $Message"
    }
    else {
        "[$Level] [$scriptNameOnly] $Message"
    }

    # Write to console if not suppressed
    if (-not $NoConsole) {
        Write-Host $formattedMessage -ForegroundColor $levelColors[$Level]
    }

    # Write to log file
    Add-Content -Path $LogFile -Value $formattedMessage
}

function Write-BIGHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Title,

        [Parameter(Mandatory = $false)]
        [string]$LogFile,

        [Parameter(Mandatory = $false)]
        [switch]$NoConsole,

        [Parameter(Mandatory = $false)]
        [string]$ForegroundColor = "Yellow",

        [Parameter(Mandatory = $false)]
        [string]$BorderColor = "Cyan"
    )

    $width = 60
    $padding = [math]::Max(0, ($width - $Title.Length - 10) / 2)
    $leftPad = [math]::Floor($padding)
    $rightPad = [math]::Ceiling($padding)

    $header = @"

$("=" * $width)
$("#" * $leftPad)  $Title  $("#" * $rightPad)
$("=" * $width)

"@

    # Write to console if not suppressed
    if (-not $NoConsole) {
        Write-Host ""
        Write-Host ("=" * $width) -ForegroundColor $BorderColor
        Write-Host ("#" * $leftPad) -ForegroundColor $BorderColor -NoNewline
        Write-Host "  $Title  " -ForegroundColor $ForegroundColor -NoNewline
        Write-Host ("#" * $rightPad) -ForegroundColor $BorderColor
        Write-Host ("=" * $width) -ForegroundColor $BorderColor
        Write-Host ""
    }

    # Write to log file if specified
    if ($LogFile) {
        Add-Content -Path $LogFile -Value $header
    }
}

function Start-BIGLogging {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ScriptName = $MyInvocation.ScriptName,

        [Parameter(Mandatory = $false)]
        [string]$LogFile
    )

    # Set default log file if not provided
    if (-not $LogFile) {
        $projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
        $logsDir = Join-Path -Path $projectRoot -ChildPath "scripts/logs"

        # Create logs directory if it doesn't exist
        if (-not (Test-Path -Path $logsDir)) {
            New-Item -Path $logsDir -ItemType Directory -Force | Out-Null
        }

        $date = Get-Date -Format "yyyy-MM-dd"
        $LogFile = Join-Path -Path $logsDir -ChildPath "BIG-Memory-$date.log"
    }

    $scriptNameOnly = Split-Path -Leaf $ScriptName
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $separator = "=" * 80

    $startMessage = @"
$separator
[$timestamp] SCRIPT START: $scriptNameOnly
$separator
"@

    # Write to log file
    Add-Content -Path $LogFile -Value $startMessage

    return $LogFile
}

function Stop-BIGLogging {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ScriptName = $MyInvocation.ScriptName,

        [Parameter(Mandatory = $false)]
        [string]$LogFile,

        [Parameter(Mandatory = $false)]
        [TimeSpan]$Duration
    )

    # Set default log file if not provided
    if (-not $LogFile) {
        $projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
        $logsDir = Join-Path -Path $projectRoot -ChildPath "scripts/logs"
        $date = Get-Date -Format "yyyy-MM-dd"
        $LogFile = Join-Path -Path $logsDir -ChildPath "BIG-Memory-$date.log"
    }

    $scriptNameOnly = Split-Path -Leaf $ScriptName
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $separator = "=" * 80

    $endMessage = if ($Duration) {
        @"
$separator
[$timestamp] SCRIPT END: $scriptNameOnly (Duration: $Duration)
$separator
"@
    }
    else {
        @"
$separator
[$timestamp] SCRIPT END: $scriptNameOnly
$separator
"@
    }

    # Write to log file
    Add-Content -Path $LogFile -Value $endMessage
}

# Export functions
Export-ModuleMember -Function Write-BIGLog, Write-BIGHeader, Start-BIGLogging, Stop-BIGLogging