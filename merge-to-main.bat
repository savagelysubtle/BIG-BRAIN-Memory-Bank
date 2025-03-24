@echo off
echo BIG BRAIN Memory Bank - Merge to Main Tool
echo ==========================================
echo.

REM Check if git is available
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: Git is not installed or not in your PATH.
    echo Please install Git and try again.
    exit /b 1
)

REM Default merge message if none provided
set MERGE_MSG=Merge development into main

REM Check if a merge message was provided as an argument
if not "%~1"=="" (
    set MERGE_MSG=%~1
)

echo Checking current branch...
git branch --show-current > current_branch.txt
set /p CURRENT_BRANCH=<current_branch.txt
del current_branch.txt

echo Current branch is: %CURRENT_BRANCH%
echo.

REM Save the current branch to return to it later
set RETURN_BRANCH=%CURRENT_BRANCH%

echo Checking for uncommitted changes...
git diff-index --quiet HEAD || (
    echo Error: You have uncommitted changes.
    echo Please commit or stash them before merging.
    exit /b 1
)

echo Switching to main branch...
git checkout main
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to switch to main branch.
    echo Returning to %RETURN_BRANCH% branch...
    git checkout %RETURN_BRANCH%
    exit /b 1
)

echo Pulling latest changes from main...
git pull origin main
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to pull changes from main.
    echo Returning to %RETURN_BRANCH% branch...
    git checkout %RETURN_BRANCH%
    exit /b 1
)

echo Merging memory-bank-dev into main WITHOUT committing...
git merge --no-commit --no-ff memory-bank-dev
if %ERRORLEVEL% NEQ 0 (
    echo Error: Merge conflict detected.
    echo Please resolve conflicts manually, then complete the merge.
    echo After resolving, push changes with: git push origin main
    exit /b 1
)

echo Checking inspiration folder status...
if not exist inspiration (
    echo Restoring inspiration folder that should remain in main...
    git reset HEAD inspiration
    git checkout -- inspiration
)

echo Committing the merge...
git commit -S -m "%MERGE_MSG%"
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to commit the merge.
    echo Returning to %RETURN_BRANCH% branch...
    git checkout %RETURN_BRANCH%
    exit /b 1
)

echo Pushing changes to remote...
git push origin main
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to push changes to remote.
    echo Please check your network connection and repository access.
    exit /b 1
)

echo Returning to %RETURN_BRANCH% branch...
git checkout %RETURN_BRANCH%

echo.
echo Merge complete! Changes from memory-bank-dev have been merged into main.
echo The inspiration folder has been preserved in the main branch.
echo.
exit /b 0