#!/bin/bash

# BIG BRAIN Memory Bank - Initialization Script Updater
# This script analyzes the current repository structure and updates the initialization scripts.
# Version 1.0.0 (March 24, 2025)

# Define colors for console output
INFO_COLOR="\033[0;36m"
SUCCESS_COLOR="\033[0;32m"
ERROR_COLOR="\033[0;31m"
HIGHLIGHT_COLOR="\033[0;33m"
RESET_COLOR="\033[0m"

# Print banner
echo -e "${INFO_COLOR}==================================================="
echo -e "  BIG BRAIN Memory Bank - Initialization Updater"
echo -e "===================================================${RESET_COLOR}"
echo ""

# Configuration
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
INIT_SCRIPT_PS1="$SCRIPT_DIR/Initialize-MemoryBank.ps1"
INIT_SCRIPT_SH="$SCRIPT_DIR/Initialize-MemoryBank.sh"
TEMP_INIT_SCRIPT_PS1="$SCRIPT_DIR/Initialize-MemoryBank.ps1.new"
TEMP_INIT_SCRIPT_SH="$SCRIPT_DIR/Initialize-MemoryBank.sh.new"
BACKUP_DIR="$SCRIPT_DIR/backup"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo -e "${INFO_COLOR}Created backup directory: $BACKUP_DIR${RESET_COLOR}"
fi

# Backup existing scripts
backup_script() {
    local script_path="$1"

    if [ -f "$script_path" ]; then
        timestamp=$(date +"%Y%m%d-%H%M%S")
        file_name=$(basename "$script_path")
        backup_path="$BACKUP_DIR/${file_name}.${timestamp}"

        cp "$script_path" "$backup_path"
        echo -e "${INFO_COLOR}Backed up $script_path to $backup_path${RESET_COLOR}"
    fi
}

# Backup existing initialization scripts
backup_script "$INIT_SCRIPT_PS1"
backup_script "$INIT_SCRIPT_SH"

# Analyze repository structure
echo -e "${INFO_COLOR}Analyzing repository structure...${RESET_COLOR}"

# Use find to discover directory structure
find_directories() {
    local base_path="$1"
    local max_depth="$2"

    # Find directories up to max_depth
    find "$base_path" -type d -mindepth 1 -maxdepth "$max_depth" | sort
}

# Generate directory creation script for PowerShell
generate_ps_directory_creation() {
    local base_path="$1"
    local base_var="$2"
    local script=""
    local dirs=$(find_directories "$base_path" 3)

    for dir in $dirs; do
        # Get relative path from base_path
        local rel_path="${dir#$base_path/}"
        # Replace slashes with underscores for variable name
        local var_name="${rel_path//\//_}Dir"
        # Get parent path
        local parent_path=$(dirname "$rel_path")
        if [ "$parent_path" = "." ]; then
            # If parent is the base path
            script+='$'"$var_name = Join-Path -Path $"$base_var" -ChildPath \"$(basename "$rel_path")\"\n"
        else
            # Replace slashes with underscores for parent variable name
            local parent_var="${parent_path//\//_}Dir"
            script+='$'"$var_name = Join-Path -Path $"$parent_var" -ChildPath \"$(basename "$rel_path")\"\n"
        fi
        script+="Create-Directory -Path $"$var_name"\n"
    done

    echo -e "$script"
}

# Generate directory creation script for Bash
generate_sh_directory_creation() {
    local base_path="$1"
    local base_var="$2"
    local script=""
    local dirs=$(find_directories "$base_path" 3)

    for dir in $dirs; do
        # Get relative path from base_path
        local rel_path="${dir#$base_path/}"
        # Replace slashes with underscores for variable name
        local var_name="${rel_path//\//_}Dir"
        # Get parent path
        local parent_path=$(dirname "$rel_path")
        if [ "$parent_path" = "." ]; then
            # If parent is the base path
            script+="$var_name=\"\$$base_var/$(basename "$rel_path")\"\n"
        else
            # Replace slashes with underscores for parent variable name
            local parent_var="${parent_path//\//_}Dir"
            script+="$var_name=\"\$$parent_var/$(basename "$rel_path")\"\n"
        fi
        script+="Create-Directory -Path \$$var_name\n"
    done

    echo -e "$script"
}

# Get memory file templates
generate_memory_templates() {
    local active_dir="$PARENT_DIR/memory-bank/core/active"
    local script=""

    if [ -d "$active_dir" ]; then
        for file in "$active_dir"/*.md; do
            if [ -f "$file" ]; then
                file_name=$(basename "$file")
                var_name="${file_name%.md}Template"
                script+="$var_name=\"@'\n"
                # Get first 30 lines of the file
                head -n 30 "$file" | while IFS= read -r line; do
                    script+="$line\n"
                done
                script+="[... Additional content truncated for template ...]\n'@\"\n\n"
            fi
        done
    fi

    echo -e "$script"
}

# Generate file creation script
generate_file_creation() {
    local active_dir="$PARENT_DIR/memory-bank/core/active"
    local script=""

    if [ -d "$active_dir" ]; then
        for file in "$active_dir"/*.md; do
            if [ -f "$file" ]; then
                file_name=$(basename "$file")
                var_name="${file_name%.md}Template"
                script+="Create-FileIfNotExists -Path (Join-Path -Path \$coreActiveDir -ChildPath \"$file_name\") -Content \$$var_name\n"
            fi
        done
    fi

    echo -e "$script"
}

# Discover structures
memory_bank_path="$PARENT_DIR/memory-bank"
rules_path="$PARENT_DIR/.cursor/rules"

echo -e "${INFO_COLOR}Discovered memory-bank structure:${RESET_COLOR}"
find_directories "$memory_bank_path" 3 | sed "s|$PARENT_DIR/||" | awk '{print "  " $0}' | sort

echo -e "${INFO_COLOR}Discovered rules structure:${RESET_COLOR}"
find_directories "$rules_path" 3 | sed "s|$PARENT_DIR/||" | awk '{print "  " $0}' | sort

# Generate directory creation scripts
memory_bank_ps_script=$(generate_ps_directory_creation "$memory_bank_path" "memoryBankDir")
rules_ps_script=$(generate_ps_directory_creation "$rules_path" "rulesDir")

memory_bank_sh_script=$(generate_sh_directory_creation "$memory_bank_path" "memoryBankDir")
rules_sh_script=$(generate_sh_directory_creation "$rules_path" "rulesDir")

# Generate memory file templates
memory_file_templates=$(generate_memory_templates)
file_creation_script=$(generate_file_creation)

# Generate new PowerShell initialization script
current_date=$(date "+%Y-%m-%d %H:%M:%S")
new_ps_script="# BIG BRAIN Memory Bank 2.0 Initialization Script
# This script initializes the complete BIG BRAIN Memory Bank structure with all required directories and files.
# Auto-generated on $current_date

Write-Host \"🧠 BIG BRAIN Memory Bank 2.0 Initialization\" -ForegroundColor Cyan
Write-Host \"=================================================\" -ForegroundColor Cyan

# Get the current script directory and parent directory
\$scriptDir = \$PSScriptRoot
\$rootDir = Split-Path -Parent \$scriptDir

# Define directory paths
\$cursorDir = Join-Path -Path \$rootDir -ChildPath \".cursor\"
\$rulesDir = Join-Path -Path \$cursorDir -ChildPath \"rules\"
\$bigBrainRulesDir = Join-Path -Path \$rulesDir -ChildPath \"BIG_BRAIN\"
\$codebaseRulesDir = Join-Path -Path \$rulesDir -ChildPath \"Codebase\"

\$memoryBankDir = Join-Path -Path \$rootDir -ChildPath \"memory-bank\"
\$coreDir = Join-Path -Path \$memoryBankDir -ChildPath \"core\"
\$coreActiveDir = Join-Path -Path \$coreDir -ChildPath \"active\"

# Create directory structure function
function Create-Directory {
    param (
        [string]\$Path
    )

    if (-not (Test-Path -Path \$Path)) {
        New-Item -ItemType Directory -Force -Path \$Path | Out-Null
        Write-Host \"  Created directory: \$Path\" -ForegroundColor Green
    }
    else {
        Write-Host \"  Directory already exists: \$Path\" -ForegroundColor Yellow
    }
}

# Create all directories
Write-Host \"Creating directory structure...\" -ForegroundColor Cyan

# Create basic structure
Create-Directory -Path \$cursorDir
Create-Directory -Path \$rulesDir
Create-Directory -Path \$bigBrainRulesDir
Create-Directory -Path \$codebaseRulesDir
Create-Directory -Path \$memoryBankDir
Create-Directory -Path \$coreDir
Create-Directory -Path \$coreActiveDir

# Create memory-bank structure
$memory_bank_ps_script

# Create rules structure
$rules_ps_script

# Create file function
function Create-FileIfNotExists {
    param (
        [string]\$Path,
        [string]\$Content
    )

    if (-not (Test-Path -Path \$Path)) {
        Set-Content -Path \$Path -Value \$Content
        Write-Host \"  Created file: \$Path\" -ForegroundColor Green
    }
    else {
        Write-Host \"  File already exists: \$Path\" -ForegroundColor Yellow
    }
}

# Create memory file templates
$memory_file_templates

# Create memory files
Write-Host \"Creating memory files...\" -ForegroundColor Cyan
$file_creation_script

Write-Host \"🎉 BIG BRAIN Memory Bank 2.0 initialization complete!\" -ForegroundColor Cyan
Write-Host \"You can now use BIG BRAIN with your project.\" -ForegroundColor Cyan
Write-Host \"Remember to use the 'BIG' command to start your interactions.\" -ForegroundColor Cyan
"

# Generate new Bash initialization script
new_sh_script="#!/bin/bash

# BIG BRAIN Memory Bank 2.0 Initialization Script
# This script initializes the complete BIG BRAIN Memory Bank structure with all required directories and files.
# Auto-generated on $current_date

echo \"🧠 BIG BRAIN Memory Bank 2.0 Initialization\"
echo \"=================================================\"

# Get the current script directory and parent directory
scriptDir=\"\$(dirname \"\$(readlink -f \"\$0\")\")"
rootDir=\"\$(dirname \"\$scriptDir\")\"

# Define directory paths
cursorDir=\"\$rootDir/.cursor\"
rulesDir=\"\$cursorDir/rules\"
bigBrainRulesDir=\"\$rulesDir/BIG_BRAIN\"
codebaseRulesDir=\"\$rulesDir/Codebase\"

memoryBankDir=\"\$rootDir/memory-bank\"
coreDir=\"\$memoryBankDir/core\"
coreActiveDir=\"\$coreDir/active\"

# Create directory structure function
Create-Directory() {
    local Path=\"\$1\"

    if [ ! -d \"\$Path\" ]; then
        mkdir -p \"\$Path\"
        echo \"  Created directory: \$Path\"
    else
        echo \"  Directory already exists: \$Path\"
    fi
}

# Create all directories
echo \"Creating directory structure...\"

# Create basic structure
Create-Directory \"\$cursorDir\"
Create-Directory \"\$rulesDir\"
Create-Directory \"\$bigBrainRulesDir\"
Create-Directory \"\$codebaseRulesDir\"
Create-Directory \"\$memoryBankDir\"
Create-Directory \"\$coreDir\"
Create-Directory \"\$coreActiveDir\"

# Create memory-bank structure
$memory_bank_sh_script

# Create rules structure
$rules_sh_script

# Create file function
Create-FileIfNotExists() {
    local Path=\"\$1\"
    local Content=\"\$2\"

    if [ ! -f \"\$Path\" ]; then
        echo \"\$Content\" > \"\$Path\"
        echo \"  Created file: \$Path\"
    else
        echo \"  File already exists: \$Path\"
    fi
}

# Create memory file templates
$memory_file_templates

# Create memory files
echo \"Creating memory files...\"
$file_creation_script

echo \"🎉 BIG BRAIN Memory Bank 2.0 initialization complete!\"
echo \"You can now use BIG BRAIN with your project.\"
echo \"Remember to use the 'BIG' command to start your interactions.\"
"

# Write new initialization scripts
echo -e "$new_ps_script" > "$TEMP_INIT_SCRIPT_PS1"
echo -e "$new_sh_script" > "$TEMP_INIT_SCRIPT_SH"

# Move the temporary files to the final locations
if [ -f "$TEMP_INIT_SCRIPT_PS1" ] && [ -f "$TEMP_INIT_SCRIPT_SH" ]; then
    mv "$TEMP_INIT_SCRIPT_PS1" "$INIT_SCRIPT_PS1"
    chmod +x "$INIT_SCRIPT_SH"
    mv "$TEMP_INIT_SCRIPT_SH" "$INIT_SCRIPT_SH"
    chmod +x "$INIT_SCRIPT_SH"
    echo -e "${SUCCESS_COLOR}✅ Successfully updated initialization scripts:${RESET_COLOR}"
    echo -e "${SUCCESS_COLOR}  - $INIT_SCRIPT_PS1${RESET_COLOR}"
    echo -e "${SUCCESS_COLOR}  - $INIT_SCRIPT_SH${RESET_COLOR}"
else
    echo -e "${ERROR_COLOR}❌ Failed to generate updated initialization scripts.${RESET_COLOR}"
fi

echo -e "${SUCCESS_COLOR}Initialization script update complete!${RESET_COLOR}"