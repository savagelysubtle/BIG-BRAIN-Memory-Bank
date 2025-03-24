# Script to delete original rule files after reorganization
# WARNING: Run this only AFTER verifying the new structure works correctly
# This script will permanently delete files, use with caution

# Base paths
$rulesPath = ".\.cursor\rules"

Write-Host "WARNING: This script will delete original rule files after reorganization." -ForegroundColor Red
Write-Host "It should only be run AFTER you have verified the new structure works correctly." -ForegroundColor Red
Write-Host "Proceed with caution as this operation cannot be undone." -ForegroundColor Red
Write-Host ""

$confirmation = Read-Host "Type 'DELETE' (all caps) to confirm deletion of original files"

if ($confirmation -ne "DELETE") {
    Write-Host "Deletion cancelled. No files were removed." -ForegroundColor Green
    exit
}

Write-Host "Proceeding with deletion of original files..." -ForegroundColor Yellow

# Files to delete from root
$rootFiles = @(
    "$rulesPath\000-big-brain-identity.mdc"
    # main.mdc remains in place
)

# Delete files from root
foreach ($file in $rootFiles) {
    if (Test-Path $file) {
        Write-Host "Deleting file: $file"
        Remove-Item -Path $file -Force
    }
}

# Folders to check and potentially delete
$foldersToProcess = @(
    "$rulesPath\Core",
    "$rulesPath\Utility",
    "$rulesPath\Extended Details",
    "$rulesPath\Frameworks",
    "$rulesPath\Languages"
)

# Process each folder
foreach ($folder in $foldersToProcess) {
    if (Test-Path $folder) {
        # Get all files in the folder and its subfolders
        $files = Get-ChildItem -Path $folder -Recurse -File

        # Delete each file
        foreach ($file in $files) {
            Write-Host "Deleting file: $($file.FullName)"
            Remove-Item -Path $file.FullName -Force
        }

        # Get all empty directories
        $emptyDirs = Get-ChildItem -Path $folder -Recurse -Directory |
                     Where-Object { (Get-ChildItem -Path $_.FullName -Recurse -File).Count -eq 0 } |
                     Sort-Object -Property FullName -Descending

        # Remove each empty directory
        foreach ($dir in $emptyDirs) {
            Write-Host "Deleting empty directory: $($dir.FullName)"
            Remove-Item -Path $dir.FullName -Force
        }

        # Check if the main folder is now empty
        if ((Get-ChildItem -Path $folder -Recurse).Count -eq 0) {
            Write-Host "Deleting empty main directory: $folder"
            Remove-Item -Path $folder -Force
        }
    }
}

Write-Host "`nCleanup complete!" -ForegroundColor Green
Write-Host "Original rule files and empty directories have been removed."
Write-Host "The new organizational structure is now the only version present."