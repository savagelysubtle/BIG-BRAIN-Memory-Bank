@echo off
echo BIG BRAIN Memory Bank Documentation Update Tool
echo ==============================================
echo.

REM Check if git is available
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: Git is not installed or not in your PATH.
    echo Please install Git and try again.
    exit /b 1
)

echo Checking git status...
git status

REM Default commit message if none provided
set COMMIT_MSG=Update documentation

REM Check if a commit message was provided as an argument
if not "%~1"=="" (
    set COMMIT_MSG=%~1
)

echo.
echo Adding all files...
git add .

echo.
echo Committing changes with message: "%COMMIT_MSG%"
git commit -S -m "%COMMIT_MSG%"

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to commit changes.
    echo Please resolve any issues and try again.
    exit /b 1
)

echo.
echo Pushing changes to remote repository...
git push

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to push changes to remote repository.
    echo Please check your network connection and repository access.
    exit /b 1
)

echo.
echo Documentation update complete!
echo Changes have been committed and pushed to the repository.
echo.
exit /b 0