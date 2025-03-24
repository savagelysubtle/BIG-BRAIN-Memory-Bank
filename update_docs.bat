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

echo.
echo Are you ready to commit and push the documentation changes? (Y/N)
set /p CONFIRM=

if /i "%CONFIRM%" NEQ "Y" (
    echo Update canceled.
    exit /b 0
)

echo.
echo Please enter a commit message describing your documentation updates:
set /p COMMIT_MSG=

if "%COMMIT_MSG%"=="" (
    set COMMIT_MSG=Update documentation
)

echo.
echo Adding documentation files...
git add docs/

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

echo Would you like to create a pull request? (Y/N)
set /p CREATE_PR=

if /i "%CREATE_PR%" EQU "Y" (
    echo.
    echo Please create a pull request on GitHub:
    echo 1. Go to your repository on GitHub
    echo 2. Click on "Pull requests"
    echo 3. Click on "New pull request"
    echo 4. Select the appropriate base and compare branches
    echo 5. Click "Create pull request"
    echo 6. Add a title and description
    echo 7. Click "Create pull request" again
)

echo.
echo Thank you for updating the BIG BRAIN Memory Bank documentation!
exit /b 0