@echo off
echo BIG BRAIN Memory Bank - Branch Content Protection
echo ===============================================
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
    echo Creating branch-specific .gitignore entries for development branch...

    echo. >> .gitignore
    echo # Branch-specific ignores for memory-bank-dev >> .gitignore
    echo /inspiration/ >> .gitignore

    echo.
    echo Added protection to prevent inspiration folder from being tracked in development branch.
    echo This ensures inspiration folder stays in main but not in development.

    echo.
    echo Committing .gitignore changes...
    git add .gitignore
    git commit -S -m "Add branch-specific content protection"
    git push

    echo.
    echo Setup complete! The inspiration folder will:
    echo  - Remain in the main branch
    echo  - Stay excluded from the development branch
    echo.
    echo This configuration will persist across future merges.
) else (
    echo Error: This script should be run from the memory-bank-dev branch.
    echo Please switch to the memory-bank-dev branch first:
    echo   git checkout memory-bank-dev
    exit /b 1
)

exit /b 0