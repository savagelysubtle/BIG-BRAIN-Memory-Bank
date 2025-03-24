#!/bin/bash

# BIG BRAIN Memory Bank - All Scripts Updater
# This script updates all initialization scripts for the Memory Bank
# Version 1.0.0 (March 24, 2025)

# Define colors for console output
INFO_COLOR="\033[0;36m"
SUCCESS_COLOR="\033[0;32m"
ERROR_COLOR="\033[0;31m"
WARNING_COLOR="\033[0;33m"
RESET_COLOR="\033[0m"

# Print banner
echo -e "${INFO_COLOR}==================================================="
echo -e "  BIG BRAIN Memory Bank - All Scripts Updater"
echo -e "===================================================${RESET_COLOR}"
echo ""

# Get script directory
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
UPDATE_PS_PATH="$SCRIPT_DIR/Update-InitializationScript.ps1"
UPDATE_SH_PATH="$SCRIPT_DIR/Update-InitializationScript.sh"

echo -e "${INFO_COLOR}Detecting environment...${RESET_COLOR}"

# Detect operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macOS"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    OS_TYPE="Windows/Cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
    OS_TYPE="Windows/MSYS"
elif [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="Windows"
else
    OS_TYPE="Unknown"
fi

# Verify existence of update scripts
PS_SCRIPT_EXISTS=0
SH_SCRIPT_EXISTS=0

if [ -f "$UPDATE_PS_PATH" ]; then
    PS_SCRIPT_EXISTS=1
fi

if [ -f "$UPDATE_SH_PATH" ]; then
    SH_SCRIPT_EXISTS=1
fi

if [ $PS_SCRIPT_EXISTS -eq 0 ] && [ $SH_SCRIPT_EXISTS -eq 0 ]; then
    echo -e "${ERROR_COLOR}❌ No update scripts found. Please ensure at least one of these files exists:${RESET_COLOR}"
    echo -e "${ERROR_COLOR}   - $UPDATE_PS_PATH${RESET_COLOR}"
    echo -e "${ERROR_COLOR}   - $UPDATE_SH_PATH${RESET_COLOR}"
    exit 1
fi

# Check for PowerShell Core
HAS_PWSH=0
if command -v pwsh &> /dev/null; then
    HAS_PWSH=1
    PWSH_VERSION=$(pwsh -c '$PSVersionTable.PSVersion.ToString()' 2>/dev/null)
fi

echo -e "${INFO_COLOR}Environment details:${RESET_COLOR}"
echo -e "${INFO_COLOR}  - Operating System: $OS_TYPE${RESET_COLOR}"
if [ $HAS_PWSH -eq 1 ]; then
    echo -e "${INFO_COLOR}  - PowerShell Core: Available (version $PWSH_VERSION)${RESET_COLOR}"
else
    echo -e "${INFO_COLOR}  - PowerShell Core: Not available${RESET_COLOR}"
fi

# Update function
update_scripts() {
    local method=$1

    echo -e "\n${INFO_COLOR}Updating scripts using $method...${RESET_COLOR}"

    case $method in
        "PowerShell")
            if [ $PS_SCRIPT_EXISTS -eq 1 ]; then
                if [ $HAS_PWSH -eq 1 ]; then
                    if pwsh -File "$UPDATE_PS_PATH"; then
                        echo -e "${SUCCESS_COLOR}✅ PowerShell initialization scripts updated successfully.${RESET_COLOR}"
                    else
                        echo -e "${ERROR_COLOR}❌ Error updating PowerShell initialization scripts.${RESET_COLOR}"
                    fi
                else
                    echo -e "${ERROR_COLOR}❌ PowerShell Core (pwsh) is not available.${RESET_COLOR}"
                fi
            else
                echo -e "${ERROR_COLOR}❌ PowerShell update script not found: $UPDATE_PS_PATH${RESET_COLOR}"
            fi
            ;;
        "Bash")
            if [ $SH_SCRIPT_EXISTS -eq 1 ]; then
                # Make sure the script is executable
                chmod +x "$UPDATE_SH_PATH"
                if bash "$UPDATE_SH_PATH"; then
                    echo -e "${SUCCESS_COLOR}✅ Bash initialization scripts updated successfully.${RESET_COLOR}"
                else
                    echo -e "${ERROR_COLOR}❌ Error updating Bash initialization scripts.${RESET_COLOR}"
                fi
            else
                echo -e "${ERROR_COLOR}❌ Bash update script not found: $UPDATE_SH_PATH${RESET_COLOR}"
            fi
            ;;
        *)
            echo -e "${ERROR_COLOR}❌ Unknown method: $method${RESET_COLOR}"
            ;;
    esac
}

# Determine best update method based on OS
case $OS_TYPE in
    "Linux"|"macOS")
        # On Unix/Linux, prefer Bash but fall back to PowerShell Core
        if [ $SH_SCRIPT_EXISTS -eq 1 ]; then
            update_scripts "Bash"
        elif [ $PS_SCRIPT_EXISTS -eq 1 ] && [ $HAS_PWSH -eq 1 ]; then
            echo -e "${WARNING_COLOR}⚠️ Bash update script not found. Using PowerShell Core...${RESET_COLOR}"
            update_scripts "PowerShell"
        else
            echo -e "${ERROR_COLOR}❌ No suitable update script found for $OS_TYPE.${RESET_COLOR}"
        fi
        ;;
    "Windows"*) # Match any Windows variants
        # On Windows, prefer PowerShell but fall back to Bash
        if [ $PS_SCRIPT_EXISTS -eq 1 ] && [ $HAS_PWSH -eq 1 ]; then
            update_scripts "PowerShell"
        elif [ $SH_SCRIPT_EXISTS -eq 1 ]; then
            echo -e "${WARNING_COLOR}⚠️ PowerShell Core not available. Attempting to use Bash...${RESET_COLOR}"
            update_scripts "Bash"
        else
            echo -e "${ERROR_COLOR}❌ No suitable update script found for $OS_TYPE.${RESET_COLOR}"
        fi
        ;;
    *)
        # Unknown platform, try both
        echo -e "${WARNING_COLOR}⚠️ Unknown platform. Attempting to use available methods...${RESET_COLOR}"
        if [ $SH_SCRIPT_EXISTS -eq 1 ]; then
            update_scripts "Bash"
        fi
        if [ $PS_SCRIPT_EXISTS -eq 1 ] && [ $HAS_PWSH -eq 1 ]; then
            update_scripts "PowerShell"
        fi
        ;;
esac

echo -e "\n${SUCCESS_COLOR}Script update process complete.${RESET_COLOR}"