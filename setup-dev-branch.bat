@echo off
echo BIG BRAIN Memory Bank Development Branch Setup
echo ==============================================
echo.

REM Check if git is available
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: Git is not installed or not in your PATH.
    echo Please install Git and try again.
    exit /b 1
)

echo Checking current branch...
git branch --show-current > current_branch.txt
set /p CURRENT_BRANCH=<current_branch.txt
del current_branch.txt

echo Current branch is: %CURRENT_BRANCH%
echo.

if "%CURRENT_BRANCH%" == "memory-bank-dev" (
    echo Already on memory-bank-dev branch.
) else (
    echo Checking if memory-bank-dev branch exists...
    git show-ref --verify --quiet refs/heads/memory-bank-dev

    if %ERRORLEVEL% EQU 0 (
        echo Branch exists. Switching to memory-bank-dev branch...
        git checkout memory-bank-dev
    ) else (
        echo Creating and switching to memory-bank-dev branch...
        git checkout -b memory-bank-dev
    )
)

echo.
echo Checking if the branch is already pushed to remote...
git ls-remote --heads origin memory-bank-dev > remote_branch.txt
set /p REMOTE_EXISTS=<remote_branch.txt
del remote_branch.txt

if not "%REMOTE_EXISTS%" == "" (
    echo Branch already exists on remote.
) else (
    echo Pushing branch to remote...
    git push -u origin memory-bank-dev
)

echo.
echo Development branch setup is complete!
echo.
echo Structure:
echo - main branch: Stable "clean install" version for new users
echo - memory-bank-dev branch: Development version with current improvements
echo.
echo Usage:
echo - For development work: Stay on memory-bank-dev branch
echo - To update the stable version: Merge from memory-bank-dev to main when ready
echo.
exit /b 0