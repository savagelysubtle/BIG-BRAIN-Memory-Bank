# BIG BRAIN Memory Bank - All Scripts Updater
# This script updates all initialization scripts for the Memory Bank
# Version 1.0.0 (March 24, 2025)

# Define colors for console output
$infoColor = "Cyan"
$successColor = "Green"
$errorColor = "Red"
$warningColor = "Yellow"

# Print banner
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host "  BIG BRAIN Memory Bank - All Scripts Updater" -ForegroundColor $infoColor
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host ""

# Get script directory
$scriptDir = $PSScriptRoot
$updatePsPath = Join-Path -Path $scriptDir -ChildPath "Update-InitializationScript.ps1"
$updateShPath = Join-Path -Path $scriptDir -ChildPath "Update-InitializationScript.sh"

Write-Host "Detecting environment..." -ForegroundColor $infoColor
$isWindowsSystem = $PSVersionTable.Platform -eq "Win32NT" -or ($PSVersionTable.PSEdition -eq "Desktop" -or $null -eq $PSVersionTable.Platform)
$isUnixSystem = $PSVersionTable.Platform -eq "Unix"
$isPSCore = $PSVersionTable.PSEdition -eq "Core"

# Verify existence of update scripts
$psScriptExists = Test-Path -Path $updatePsPath
$shScriptExists = Test-Path -Path $updateShPath

if (-not ($psScriptExists -or $shScriptExists)) {
    Write-Host "❌ No update scripts found. Please ensure at least one of these files exists:" -ForegroundColor $errorColor
    Write-Host "   - $updatePsPath" -ForegroundColor $errorColor
    Write-Host "   - $updateShPath" -ForegroundColor $errorColor
    exit 1
}

Write-Host "Environment details:" -ForegroundColor $infoColor
Write-Host "  - Operating System: $($isWindowsSystem ? 'Windows' : ($isUnixSystem ? 'Unix/Linux' : 'Unknown'))" -ForegroundColor $infoColor
Write-Host "  - PowerShell Edition: $($isPSCore ? 'Core' : 'Desktop')" -ForegroundColor $infoColor
Write-Host "  - PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor $infoColor

# Update function
function Update-Scripts {
    param (
        [string]$Method
    )

    Write-Host "`nUpdating scripts using $Method..." -ForegroundColor $infoColor

    # Update scripts
    switch ($Method) {
        "PowerShell" {
            if ($psScriptExists) {
                try {
                    & $updatePsPath
                    Write-Host "✅ PowerShell initialization scripts updated successfully." -ForegroundColor $successColor
                }
                catch {
                    Write-Host "❌ Error updating PowerShell initialization scripts: $_" -ForegroundColor $errorColor
                }
            }
            else {
                Write-Host "❌ PowerShell update script not found: $updatePsPath" -ForegroundColor $errorColor
            }
        }
        "Bash" {
            if ($shScriptExists) {
                try {
                    # Check if running on Unix/Linux
                    if ($isUnixSystem) {
                        # Make the script executable if needed
                        if (-not (Get-Item $updateShPath).UnixMode -match "x") {
                            & chmod +x $updateShPath
                        }
                        # Run the Bash script
                        & bash $updateShPath
                        Write-Host "✅ Bash initialization scripts updated successfully." -ForegroundColor $successColor
                    }
                    else {
                        # On Windows, need WSL or similar
                        $hasBash = $null -ne (Get-Command bash -ErrorAction SilentlyContinue)
                        $hasWSL = $null -ne (Get-Command wsl -ErrorAction SilentlyContinue)

                        if ($hasBash) {
                            & bash $updateShPath
                            Write-Host "✅ Bash initialization scripts updated using bash." -ForegroundColor $successColor
                        }
                        elseif ($hasWSL) {
                            & wsl bash $updateShPath
                            Write-Host "✅ Bash initialization scripts updated using WSL." -ForegroundColor $successColor
                        }
                        else {
                            Write-Host "❌ Cannot run Bash script on Windows without bash or WSL." -ForegroundColor $errorColor
                        }
                    }
                }
                catch {
                    Write-Host "❌ Error updating Bash initialization scripts: $_" -ForegroundColor $errorColor
                }
            }
            else {
                Write-Host "❌ Bash update script not found: $updateShPath" -ForegroundColor $errorColor
            }
        }
        default {
            Write-Host "❌ Unknown method: $Method" -ForegroundColor $errorColor
        }
    }
}

# Determine best update method
if ($isWindowsSystem) {
    # On Windows, prefer PowerShell
    if ($psScriptExists) {
        Update-Scripts -Method "PowerShell"
    }
    else {
        Write-Host "⚠️ PowerShell update script not found. Attempting to use Bash..." -ForegroundColor $warningColor
        Update-Scripts -Method "Bash"
    }
}
elseif ($isUnixSystem) {
    # On Unix/Linux, prefer Bash but fall back to PowerShell Core
    if ($shScriptExists) {
        Update-Scripts -Method "Bash"
    }
    elseif ($psScriptExists) {
        Write-Host "⚠️ Bash update script not found. Using PowerShell Core..." -ForegroundColor $warningColor
        Update-Scripts -Method "PowerShell"
    }
}
else {
    # Unknown platform, try both
    Write-Host "⚠️ Unknown platform. Attempting to use available methods..." -ForegroundColor $warningColor
    if ($psScriptExists) {
        Update-Scripts -Method "PowerShell"
    }
    if ($shScriptExists) {
        Update-Scripts -Method "Bash"
    }
}

Write-Host "`nScript update process complete." -ForegroundColor $successColor