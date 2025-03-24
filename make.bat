@echo off
REM Windows Makefile alternative for BIG BRAIN Memory Bank 2.0 Documentation

set DOCS_DIR=docs
set BUNDLE=bundle
set JEKYLL=%BUNDLE% exec jekyll

if "%1"=="" goto :help

if "%1"=="setup" goto :setup
if "%1"=="serve" goto :serve
if "%1"=="build" goto :build
if "%1"=="clean" goto :clean
if "%1"=="validate" goto :validate
if "%1"=="update-deps" goto :update_deps
if "%1"=="new-page" goto :new_page
if "%1"=="gh-pages" goto :gh_pages
if "%1"=="help" goto :help

echo Unknown command: %1
goto :help

:help
echo BIG BRAIN Memory Bank 2.0 Documentation Makefile Alternative
echo.
echo Available commands:
echo   setup       - Install required dependencies for documentation site
echo   serve       - Run a local development server
echo   build       - Build the documentation site for production
echo   clean       - Remove build artifacts
echo   validate    - Check for broken links and HTML issues
echo   update-deps - Update Ruby dependencies
echo   new-page    - Create a new documentation page (args: NAME=page_name SECTION=section_name)
echo   gh-pages    - Prepare documentation for GitHub Pages
echo   help        - Show this help message
echo.
echo Example usage:
echo   make.bat serve     - Start local development server
echo   make.bat new-page NAME=installation SECTION=guides - Create a new page in guides section
echo   make.bat gh-pages  - Prepare for GitHub Pages deployment
exit /b 0

:setup
echo Setting up documentation dependencies...
cd %DOCS_DIR% && %BUNDLE% install
echo Setup complete. You can now run 'make.bat serve' to start the local server.
exit /b 0

:serve
echo Starting local server at http://localhost:4000
cd %DOCS_DIR% && %JEKYLL% serve
exit /b 0

:build
echo Building documentation site...
cd %DOCS_DIR% && set JEKYLL_ENV=production&& %JEKYLL% build
echo Build complete. Output is in %DOCS_DIR%/_site.
exit /b 0

:clean
echo Cleaning build artifacts...
cd %DOCS_DIR% && %JEKYLL% clean
echo Cleanup complete.
exit /b 0

:validate
echo Validating documentation links and HTML...
cd %DOCS_DIR% && set JEKYLL_ENV=production&& %JEKYLL% build --strict_front_matter
cd %DOCS_DIR% && %BUNDLE% exec htmlproofer ./_site --disable-external --allow-hash-href
echo Validation complete.
exit /b 0

:update_deps
echo Updating Ruby dependencies...
cd %DOCS_DIR% && %BUNDLE% update
echo Dependencies updated.
exit /b 0

:new_page
if "%NAME%"=="" (
    echo Error: NAME parameter is required. Example: make.bat new-page NAME=installation SECTION=guides
    exit /b 1
)
if "%SECTION%"=="" (
    echo Error: SECTION parameter is required. Example: make.bat new-page NAME=installation SECTION=guides
    exit /b 1
)

echo Creating new page: %NAME% in section: %SECTION%
mkdir %DOCS_DIR%\%SECTION% 2>nul

echo --- > %DOCS_DIR%\%SECTION%\%NAME%.md
echo layout: default >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo title: %NAME% >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo parent: %SECTION% >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo nav_order: 1 >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo permalink: /%SECTION%/%NAME%/ >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo --- >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo. >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo # %NAME% >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo. >> %DOCS_DIR%\%SECTION%\%NAME%.md
echo Content for %NAME% goes here. >> %DOCS_DIR%\%SECTION%\%NAME%.md

echo Page created at %DOCS_DIR%\%SECTION%\%NAME%.md
exit /b 0

:gh_pages
call :build

echo Preparing documentation for GitHub Pages...

echo Checking frontmatter in markdown files...
cd %DOCS_DIR% && call scripts\update_docs.bat fix-frontmatter

echo Checking for CNAME file...
if not exist %DOCS_DIR%\CNAME (
    echo Creating a placeholder CNAME file (update this with your actual domain if needed)
    echo # Replace with your custom domain if using one > %DOCS_DIR%\CNAME
)

echo Checking for Gemfile.lock...
if not exist %DOCS_DIR%\Gemfile.lock (
    echo Running bundle install to generate Gemfile.lock
    cd %DOCS_DIR% && %BUNDLE% install
)

echo GitHub Pages preparation complete.
echo To deploy to GitHub Pages:
echo 1. Commit all changes to your repository
echo 2. Push to the main branch
echo 3. Go to your repository settings and enable GitHub Pages for the docs/ folder
exit /b 0