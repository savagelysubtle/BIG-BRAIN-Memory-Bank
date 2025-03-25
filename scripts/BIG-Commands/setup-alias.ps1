# setup-alias.ps1
# Setup script to create a system-wide 'big' alias
# Version 1.0.0
# Created: 2025-03-29

# Get the full path to the BIG wrapper script
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "BIG-Wrapper.ps1"

# Create a batch file that invokes the BIG wrapper
$batchContent = @"
@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$scriptPath" %*
"@

# Create a 'big.bat' file in a directory that's on the PATH
$targetDir = "$env:USERPROFILE\bin"
if (-not (Test-Path -Path $targetDir)) {
    try {
        New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
        Write-Host "Created directory: $targetDir" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create directory: $targetDir" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        exit 1
    }
}

$batchFile = Join-Path -Path $targetDir -ChildPath "big.bat"
try {
    Set-Content -Path $batchFile -Value $batchContent -Force
    Write-Host "Created batch file: $batchFile" -ForegroundColor Green
}
catch {
    Write-Host "Failed to create batch file: $batchFile" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}

# Add the user bin directory to PATH if it's not already there
$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if (-not $userPath.Contains($targetDir)) {
    try {
        [Environment]::SetEnvironmentVariable("PATH", "$userPath;$targetDir", "User")
        Write-Host "Added $targetDir to your PATH environment variable" -ForegroundColor Green
        Write-Host "You may need to restart your terminal for the changes to take effect" -ForegroundColor Yellow
    }
    catch {
        Write-Host "Failed to update PATH environment variable" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        Write-Host "Please manually add $targetDir to your PATH" -ForegroundColor Yellow
    }
}
else {
    Write-Host "$targetDir is already in your PATH" -ForegroundColor Green
}

# Add a reference in the user's PowerShell profile
$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path -Parent $profilePath

if (-not (Test-Path -Path $profileDir)) {
    try {
        New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
        Write-Host "Created PowerShell profile directory: $profileDir" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create PowerShell profile directory: $profileDir" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

if (-not (Test-Path -Path $profilePath)) {
    try {
        Set-Content -Path $profilePath -Value "# PowerShell profile created by BIG setup script" -Force
        Write-Host "Created PowerShell profile: $profilePath" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create PowerShell profile: $profilePath" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# Add BIG profile to user's PowerShell profile if not already there
$bigProfilePath = Join-Path -Path (Split-Path -Parent $PSScriptRoot) -ChildPath "profiles\BIG-Profile.ps1"
$profileContent = Get-Content -Path $profilePath -Raw -ErrorAction SilentlyContinue
$profileImport = ". `"$bigProfilePath`""

if (-not $profileContent -or -not $profileContent.Contains($bigProfilePath)) {
    try {
        Add-Content -Path $profilePath -Value "`n# BIG Memory Bank System`n$profileImport" -Force
        Write-Host "Added BIG profile to your PowerShell profile: $profilePath" -ForegroundColor Green
        Write-Host "You will need to restart your PowerShell session to use the 'big' command" -ForegroundColor Yellow
    }
    catch {
        Write-Host "Failed to update PowerShell profile: $profilePath" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        Write-Host "Please manually add the following line to your profile:" -ForegroundColor Yellow
        Write-Host $profileImport -ForegroundColor Yellow
    }
}
else {
    Write-Host "BIG profile is already in your PowerShell profile" -ForegroundColor Green
}

Write-Host "`nSetup completed successfully!" -ForegroundColor Green
Write-Host "You can now use the 'big' command from any directory." -ForegroundColor Cyan
Write-Host "Try 'big help' to get started." -ForegroundColor Cyan