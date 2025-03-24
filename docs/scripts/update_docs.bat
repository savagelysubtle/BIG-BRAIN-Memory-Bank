@echo off
REM Script for managing BIG BRAIN Memory Bank 2.0 documentation

set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%.."

if "%1"=="" goto :usage

if "%1"=="check-links" goto :check_links
if "%1"=="update-nav" goto :update_nav
if "%1"=="fix-frontmatter" goto :fix_frontmatter
if "%1"=="build-search" goto :build_search
if "%1"=="help" goto :usage

echo Unknown command: %1
goto :usage

:usage
echo BIG BRAIN Documentation Updater
echo Usage: %0 [command]
echo.
echo Commands:
echo   check-links   - Check for broken links in documentation
echo   update-nav    - Update navigation based on file structure
echo   fix-frontmatter - Fix common frontmatter issues
echo   build-search  - Build search index for documentation
echo   help          - Show this help message
exit /b 0

:check_links
echo Checking for broken links...
bundle exec htmlproofer ./_site --disable-external --allow-hash-href
echo Link check complete.
exit /b 0

:update_nav
echo Updating navigation based on file structure...
REM This is a simplified placeholder - a real implementation would use a more robust tool
echo # Auto-generated navigation > _data/navigation.yml.new
echo main: >> _data/navigation.yml.new
echo   - title: "Home" >> _data/navigation.yml.new
echo     url: / >> _data/navigation.yml.new

REM This would be expanded with PowerShell for a real implementation
REM to scan directories and update the navigation structure

move /y _data/navigation.yml.new _data/navigation.yml
echo Navigation updated.
exit /b 0

:fix_frontmatter
echo Fixing common frontmatter issues...
powershell -Command "& {foreach($file in Get-ChildItem -Path . -Filter *.md -Recurse -Exclude _site) {if(!(Select-String -Path $file.FullName -Pattern '^---' -Quiet)) {Write-Host \"Adding frontmatter to $($file.FullName)\"; $title = (Select-String -Path $file.FullName -Pattern '^# ' | Select-Object -First 1).Line -replace '^# ', ''; if(!$title) {$title = $file.BaseName -replace '_', ' ' -replace '^\w', { $args[0].Value.ToUpper() }}; $content = Get-Content -Path $file.FullName -Raw; $frontmatter = \"---`r`nlayout: default`r`ntitle: $title`r`n---`r`n`r`n\"; Set-Content -Path $file.FullName -Value \"$frontmatter$content\"}}}"
echo Frontmatter fixes complete.
exit /b 0

:build_search
echo Building search index...
REM This is a placeholder for search index generation
echo Search index build complete.
exit /b 0