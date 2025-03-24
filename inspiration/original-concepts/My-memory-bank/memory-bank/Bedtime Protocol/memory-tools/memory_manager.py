#!/usr/bin/env python3
"""
Memory Manager Script - Bedtime Protocol

This script safely manages memory files by:
1. First performing a mandatory dry run to preview changes
2. Copying original files to long-term memory for archival
3. Requesting confirmation that files were correctly copied
4. Moving original files to the Windows recycle bin (never permanently deleting)

The script assumes that new versioned files (e.g., activeContext_v1.2.md) have
already been created in the root directory and will remain there as active memory.

New features:
- Organizes files into category folders in long-term memory
- Detects appropriate categories based on file content and name
- Reorganizes existing "loose" files into category folders
- Optimizes memory usage for large operations
- Maintains detailed log of organizational structure

Usage:
    python memory_manager.py [config_file] [--force-overwrite]
    python memory_manager.py [config_file] [--recycle-confirmed]
    python memory_manager.py [config_file] [--organize-by-category]
    python memory_manager.py [config_file] [--reorganize-existing]
    python memory_manager.py [config_file] [--analyze-organization]

Arguments:
    config_file          Path to the JSON configuration file (default: memory_config.json)
    --force-overwrite    Allow overwriting of existing destination files
    --recycle-confirmed  Skip to recycling bin operations (only use after successful file copying)
    --organize-by-category   Organize files into category folders in long-term memory
    --reorganize-existing    Organize existing files in long-term memory into category folders
    --analyze-organization   Analyze current organization without making changes
    --category-detection     Method for detecting file categories (basic, smart, content-based)
"""

import argparse
import ctypes
import gc
import json
import logging
import os
import re
import shutil
import sys
import textwrap
from datetime import datetime
from logging.handlers import RotatingFileHandler
from pathlib import Path
from typing import Any

try:
    import psutil

    PSUTIL_AVAILABLE = True
except ImportError:
    PSUTIL_AVAILABLE = False
    print("Note: psutil not available. Memory usage monitoring disabled.")


# ANSI color codes for console output
class Colors:
    BLUE = "\033[94m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"
    END = "\033[0m"


def print_colored(message: str, color: str) -> None:
    """Print colored text to console."""
    print(f"{color}{message}{Colors.END}")


def print_header(message: str) -> None:
    """Print a header message."""
    print("\n" + "=" * 80)
    print_colored(f" {message}", Colors.BOLD + Colors.BLUE)
    print("=" * 80)


def print_success(message: str) -> None:
    """Print a success message."""
    print_colored(f"✓ SUCCESS: {message}", Colors.GREEN)


def print_warning(message: str) -> None:
    """Print a warning message."""
    print_colored(f"⚠ WARNING: {message}", Colors.YELLOW)


def print_error(message: str) -> None:
    """Print an error message."""
    print_colored(f"✗ ERROR: {message}", Colors.RED)


def print_info(message: str) -> None:
    """Print an info message."""
    print_colored(f"ℹ {message}", Colors.BLUE)


# Find memory-bank root directory
def find_memory_bank_root() -> Path:
    """
    Find the memory-bank root directory

    Since the script location is fixed, this function provides a direct path
    to the memory-bank folder without needing complex traversal logic.
    """
    # Get the script directory
    script_path = Path(os.path.dirname(os.path.abspath(__file__)))

    # The memory-bank folder is always two levels up from the script
    # (script is in memory-bank/Bedtime Protocol/memory-tools)
    memory_bank_path = script_path.parent.parent

    print_info(f"Memory bank root identified as: {memory_bank_path}")
    return memory_bank_path


# Get the script directory and memory-bank root
script_dir = Path(os.path.dirname(os.path.abspath(__file__)))
logs_dir = script_dir / "logs"
memory_bank_root = find_memory_bank_root()

# Ensure logs directory exists
if not logs_dir.exists():
    logs_dir.mkdir(parents=True, exist_ok=True)

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler(
            logs_dir / f"memory_manager_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        ),
    ],
)
logger = logging.getLogger("memory_manager")


def ensure_directory_exists(directory: Path) -> None:
    """Create directory if it doesn't exist."""
    if not directory.exists():
        logger.info(f"Creating directory: {directory}")
        print_info(f"Creating directory: {directory}")
        directory.mkdir(parents=True, exist_ok=True)


def get_user_confirmation(prompt: str) -> bool:
    """Get confirmation from the user."""
    while True:
        response = input(f"\n{prompt} (y/n): ").strip().lower()
        if response == "y":
            return True
        elif response == "n":
            return False
        else:
            print_warning("Please enter 'y' for yes or 'n' for no.")


def log_memory_usage() -> str:
    """Log current memory usage if psutil is available."""
    if not PSUTIL_AVAILABLE:
        return "Memory monitoring not available (psutil not installed)"

    process = psutil.Process(os.getpid())
    memory_info = process.memory_info()
    memory_mb = memory_info.rss / (1024 * 1024)  # Convert to MB

    memory_msg = f"Current memory usage: {memory_mb:.2f} MB"
    logger.info(memory_msg)
    return memory_msg


def trigger_garbage_collection() -> None:
    """Explicitly trigger garbage collection to free memory."""
    if PSUTIL_AVAILABLE:
        before = psutil.Process(os.getpid()).memory_info().rss / (1024 * 1024)

    gc.collect()

    if PSUTIL_AVAILABLE:
        after = psutil.Process(os.getpid()).memory_info().rss / (1024 * 1024)
        freed = before - after
        if freed > 0:
            logger.info(f"Garbage collection freed {freed:.2f} MB of memory")


def determine_file_category(
    file_path: Path, detection_method: str = "smart", content_sample_lines: int = 20
) -> str:
    """
    Determine the appropriate category folder for a file.

    Args:
        file_path: Path to the file
        detection_method: Method for detecting categories ('basic', 'smart', 'content-based')
        content_sample_lines: Number of lines to sample for content-based detection

    Returns:
        Category name for folder organization
    """
    # Get filename without extension
    base_name = file_path.stem

    # Special case handling
    if base_name == "storage_log":
        return "metadata"

    if base_name.startswith("AAA_"):
        return "priority"

    # Basic detection just uses the base name without version
    if detection_method == "basic" or not file_path.exists():
        # Remove version suffix if present (e.g., _v1.2)
        if "_v" in base_name:
            base_name = base_name.split("_v")[0]
        return base_name

    # Smart detection uses patterns in the filename and basic content checks
    categories = {
        "projectbrief": ["project", "brief", "overview", "summary"],
        "productContext": ["product", "context", "requirements", "goals"],
        "activeContext": ["active", "context", "current", "status"],
        "systemPatterns": ["system", "patterns", "architecture", "design"],
        "techContext": ["tech", "technology", "stack", "environment"],
        "progress": ["progress", "status", "achievement", "milestone"],
        "refactoring": ["refactor", "restructure", "improve", "clean"],
        "architecture": ["architect", "structure", "design", "pattern"],
        "codebase": ["code", "codebase", "analysis", "review"],
        "import": ["import", "module", "library", "dependency"],
        "research": ["research", "study", "investigation", "analysis"],
        "metadata": ["meta", "about", "log", "record"],
    }

    # If the filename contains a recognized category, use that
    for category, keywords in categories.items():
        if any(keyword in base_name.lower() for keyword in keywords):
            return category

    # For more advanced content-based detection
    if detection_method == "content-based" and file_path.exists():
        try:
            # Sample the first few lines of the file
            content_sample = ""
            with open(file_path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    if i >= content_sample_lines:
                        break
                    content_sample += line

            # Look for category indicators in the content
            content_lower = content_sample.lower()
            for category, keywords in categories.items():
                if any(keyword in content_lower for keyword in keywords):
                    return category
        except Exception as e:
            logger.warning(f"Error reading file for content-based categorization: {e}")

    # If we couldn't determine a category, use the base name without version
    if "_v" in base_name:
        base_name = base_name.split("_v")[0]
    return base_name


def create_category_folder_structure(
    base_dir: Path, category: str, create_metadata: bool = True
) -> Path:
    """
    Create category folder with appropriate structure and metadata.

    Args:
        base_dir: Base directory where category folder should exist
        category: Name of the category folder
        create_metadata: Whether to create/update category metadata file

    Returns:
        Path to the category folder
    """
    category_folder = base_dir / category

    # Create the folder if it doesn't exist
    if not category_folder.exists():
        logger.info(f"Creating category folder: {category_folder}")
        print_info(f"Creating category folder: {category_folder}")
        category_folder.mkdir(parents=True, exist_ok=True)

    # Create or update metadata file
    if create_metadata:
        metadata_file = category_folder / ".category_info.md"

        # If the file exists, update it; otherwise, create it
        if metadata_file.exists():
            try:
                with open(metadata_file, encoding="utf-8") as f:
                    content = f.read()

                # Update the last modified date
                if "Last Updated:" in content:
                    content = re.sub(
                        r"Last Updated: .*",
                        f"Last Updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
                        content,
                    )
                else:
                    content += f"\nLast Updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"

                with open(metadata_file, "w", encoding="utf-8") as f:
                    f.write(content)
            except Exception as e:
                logger.warning(f"Error updating category metadata: {e}")
        else:
            try:
                category_description = get_category_description(category)

                metadata_content = f"""# {category.capitalize()} Category

{category_description}

## Contents

Files in this category contain information related to {category.lower()}.

## Metadata

* Created: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
* Last Updated: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
* Category Type: {get_category_type(category)}
"""
                with open(metadata_file, "w", encoding="utf-8") as f:
                    f.write(metadata_content)

                logger.info(f"Created category metadata file: {metadata_file}")
            except Exception as e:
                logger.warning(f"Error creating category metadata: {e}")

    return category_folder


def get_category_description(category: str) -> str:
    """Get a description for a category."""
    descriptions = {
        "projectbrief": "Project brief documents outlining core requirements and goals.",
        "productContext": "Product context files explaining why the project exists and user experience goals.",
        "activeContext": "Active context documents showing current work focus and recent changes.",
        "systemPatterns": "System architecture patterns, technical decisions, and component relationships.",
        "techContext": "Technical context files listing technologies, development setup, and constraints.",
        "progress": "Progress tracking documents showing what works, what's left to build, and known issues.",
        "refactoring": "Refactoring plans and implementation approaches for code improvements.",
        "architecture": "Architecture documents detailing system structure and design patterns.",
        "codebase": "Codebase analysis and documentation files.",
        "import": "Import and dependency management documentation.",
        "research": "Research documents and investigation findings.",
        "metadata": "Metadata and logging information about the memory system.",
        "priority": "High-priority documents that should be easily accessible.",
    }

    return descriptions.get(category, f"Documents related to {category}.")


def get_category_type(category: str) -> str:
    """Get the type classification for a category."""
    core_categories = {
        "projectbrief",
        "productContext",
        "activeContext",
        "systemPatterns",
        "techContext",
        "progress",
    }

    special_categories = {"metadata", "priority"}

    if category in core_categories:
        return "Core"
    elif category in special_categories:
        return "Special"
    else:
        return "Extended"


def analyze_long_term_memory(
    ltm_dir: Path, category_detection: str = "smart"
) -> dict[str, Any]:
    """
    Analyze the current state of long-term memory storage.

    Args:
        ltm_dir: Path to the long-term memory directory
        category_detection: Method for detecting categories

    Returns:
        Dict containing analysis results
    """
    print_header("ANALYZING LONG-TERM MEMORY ORGANIZATION")

    if not ltm_dir.exists():
        print_error(f"Long-term memory directory does not exist: {ltm_dir}")
        return {
            "status": "error",
            "message": f"Directory does not exist: {ltm_dir}",
            "loose_files": [],
            "categories": {},
            "recommended_actions": [],
        }

    # Find all markdown files directly in the long-term memory directory
    loose_files = [f for f in ltm_dir.glob("*.md") if f.is_file()]
    loose_file_paths = [str(f.relative_to(ltm_dir)) for f in loose_files]

    # Find existing category folders
    existing_categories = {}
    for item in ltm_dir.iterdir():
        if item.is_dir():
            category_name = item.name
            files_in_category = list(item.glob("*.md"))
            existing_categories[category_name] = {
                "path": str(item.relative_to(ltm_dir)),
                "file_count": len(files_in_category),
                "files": [str(f.relative_to(item)) for f in files_in_category],
                "has_metadata": (item / ".category_info.md").exists(),
            }

    # Categorize loose files
    file_categories = {}
    for file_path in loose_files:
        category = determine_file_category(file_path, category_detection)
        if category not in file_categories:
            file_categories[category] = []
        file_categories[category].append(str(file_path.relative_to(ltm_dir)))

    # Generate recommendations
    recommendations = []

    if loose_files:
        recommendations.append(
            {
                "type": "organize_loose_files",
                "description": f"Organize {len(loose_files)} loose files into category folders",
                "details": file_categories,
            }
        )

    for category_name, category_info in existing_categories.items():
        if not category_info["has_metadata"]:
            recommendations.append(
                {
                    "type": "add_category_metadata",
                    "description": f"Add metadata to category folder: {category_name}",
                    "category": category_name,
                }
            )

    # Check for missing core categories
    core_categories = [
        "projectbrief",
        "productContext",
        "activeContext",
        "systemPatterns",
        "techContext",
        "progress",
    ]

    missing_core = [
        cat
        for cat in core_categories
        if cat not in existing_categories and cat not in file_categories
    ]

    if missing_core:
        recommendations.append(
            {
                "type": "create_core_categories",
                "description": f"Create folders for missing core categories: {', '.join(missing_core)}",
                "categories": missing_core,
            }
        )

    # Prepare summary
    total_files = len(loose_files) + sum(
        cat["file_count"] for cat in existing_categories.values()
    )

    analysis_result = {
        "status": "success",
        "timestamp": datetime.now().isoformat(),
        "loose_files": loose_file_paths,
        "loose_file_count": len(loose_files),
        "categories": existing_categories,
        "category_count": len(existing_categories),
        "total_files": total_files,
        "organization_percentage": 100 - (len(loose_files) / total_files * 100)
        if total_files > 0
        else 0,
        "file_categories": file_categories,
        "recommended_actions": recommendations,
    }

    # Print summary
    print_info(f"Found {len(loose_files)} loose files needing organization")
    print_info(f"Found {len(existing_categories)} existing category folders")
    print_info(f"Total files in long-term memory: {total_files}")

    if loose_files:
        print_info("\nProposed categorization:")
        for category, files in file_categories.items():
            print_info(f"  {category}: {len(files)} files")

    if recommendations:
        print_info("\nRecommended actions:")
        for rec in recommendations:
            print_info(f"  - {rec['description']}")

    return analysis_result


def reorganize_existing_files(
    ltm_dir: Path,
    analysis: dict[str, Any] | None = None,
    dry_run: bool = True,
    options: dict[str, Any] | None = None,
    batch_size: int = 10,
) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    """
    Reorganize existing files based on analysis results.

    Args:
        ltm_dir: Path to the long-term memory directory
        analysis: Analysis results from analyze_long_term_memory (if None, will perform analysis)
        dry_run: If True, only simulate operations
        options: Dictionary of options for reorganization
        batch_size: Number of files to process in each batch for memory efficiency

    Returns:
        Tuple of (successful_operations, failed_operations)
    """
    if options is None:
        options = {
            "force_overwrite": False,
            "create_metadata": True,
            "category_detection": "smart",
        }

    if analysis is None:
        analysis = analyze_long_term_memory(
            ltm_dir, options.get("category_detection", "smart")
        )

    if analysis["status"] != "success" or not analysis["loose_files"]:
        if dry_run:
            print_info("No loose files to organize")
        return ([], [])

    print_header(
        f"{'DRY RUN: ' if dry_run else ''}REORGANIZING FILES IN LONG-TERM MEMORY"
    )

    successful_operations = []
    failed_operations = []

    # Process files by category for better organization and memory efficiency
    file_categories = analysis["file_categories"]

    for category, files in file_categories.items():
        # Create category folder structure
        category_folder = create_category_folder_structure(
            ltm_dir,
            category,
            create_metadata=options.get("create_metadata", True) and not dry_run,
        )

        print_info(f"Processing category: {category} ({len(files)} files)")

        # Process files in batches to optimize memory usage
        for i in range(0, len(files), batch_size):
            batch = files[i : i + batch_size]
            log_memory_usage()

            for file_path_str in batch:
                file_path = ltm_dir / file_path_str
                destination_path = category_folder / file_path.name

                operation_details = {
                    "source": str(file_path),
                    "destination": str(destination_path),
                    "category": category,
                    "timestamp": datetime.now().isoformat(),
                }

                if dry_run:
                    print_info(
                        f"[DRY RUN] Would move: {file_path.name} → {category}/{file_path.name}"
                    )
                    successful_operations.append(operation_details)
                    continue

                try:
                    # Check if destination exists
                    if destination_path.exists() and not options.get(
                        "force_overwrite", False
                    ):
                        print_warning(
                            f"Destination file already exists, skipping: {destination_path}"
                        )
                        operation_details["status"] = "skipped"
                        operation_details["reason"] = "destination_exists"
                        failed_operations.append(operation_details)
                        continue

                    # Copy first, then delete to ensure no data loss
                    shutil.copy2(file_path, destination_path)

                    # Verify the copy succeeded
                    if (
                        not destination_path.exists()
                        or file_path.stat().st_size != destination_path.stat().st_size
                    ):
                        print_error(f"Verification failed for: {file_path.name}")
                        operation_details["status"] = "failed"
                        operation_details["reason"] = "verification_failed"
                        failed_operations.append(operation_details)
                        continue

                    # Remove original file
                    file_path.unlink()

                    print_success(
                        f"Moved: {file_path.name} → {category}/{file_path.name}"
                    )
                    operation_details["status"] = "success"
                    successful_operations.append(operation_details)

                except Exception as e:
                    print_error(f"Error moving file {file_path.name}: {e}")
                    operation_details["status"] = "failed"
                    operation_details["reason"] = str(e)
                    failed_operations.append(operation_details)

            # Free memory after each batch
            trigger_garbage_collection()

    # Print summary
    print_header(f"{'DRY RUN: ' if dry_run else ''}REORGANIZATION SUMMARY")
    print_success(f"Successfully organized: {len(successful_operations)}")
    if failed_operations:
        print_error(f"Failed to organize: {len(failed_operations)}")

    return (successful_operations, failed_operations)


def update_storage_log_with_organization(
    ltm_dir: Path,
    operations: list[dict[str, Any]],
    organization_type: str = "reorganization",
) -> bool:
    """
    Update storage log with details of organizational changes.

    Args:
        ltm_dir: Path to the long-term memory directory
        operations: List of successful operations
        organization_type: Type of organization performed

    Returns:
        True if log was updated successfully, False otherwise
    """
    if not operations:
        return False

    log_file = ltm_dir / "storage_log.md"
    if not log_file.exists():
        print_warning(f"Storage log not found: {log_file}")
        return False

    try:
        with open(log_file, encoding="utf-8") as f:
            content = f.read()

        # Create new log entry
        timestamp = datetime.now().strftime("%Y-%m-%d")
        operation_count = len(operations)

        categorized_files = {}
        for op in operations:
            category = op.get("category", "unknown")
            if category not in categorized_files:
                categorized_files[category] = []
            categorized_files[category].append(Path(op["source"]).name)

        entry_title = (
            f"### {timestamp}: Memory Organization - {organization_type.capitalize()}"
        )

        log_entry = f"""
{entry_title}

**Operation Type:** Memory Organization **Performed By:** BIG BRAIN
**Timestamp:** {datetime.now().isoformat()}

**Organization Details:**

- Reorganized {operation_count} files into category folders
- Implemented hierarchical organization structure in long-term memory
- Created organized categories for improved file management
"""

        # Add categories and files
        for category, files in categorized_files.items():
            if len(files) > 5:
                file_list = files[:5]
                file_str = ", ".join(file_list) + f" and {len(files) - 5} more"
            else:
                file_str = ", ".join(files)

            log_entry += f"- **{category}**: {file_str}\n"

        log_entry += "\n**Purpose:** Improved organization and accessibility of memory files through categorized structure.\n"

        # Insert the new entry after the "## Latest Operations" line
        if "## Latest Operations" in content:
            updated_content = content.replace(
                "## Latest Operations", "## Latest Operations\n" + log_entry
            )
        else:
            # Fallback if the expected header isn't found
            updated_content = content + "\n\n" + log_entry

        # Write the updated content back to the file
        with open(log_file, "w", encoding="utf-8") as f:
            f.write(updated_content)

        print_success("Updated storage log with organization details")
        return True

    except Exception as e:
        print_error(f"Error updating storage log: {e}")
        return False


def safe_copy_file(
    source: Path,
    destination: Path,
    dry_run: bool = False,
    force_overwrite: bool = False,
) -> bool:
    """
    Safely copy a file without overwriting existing files unless force_overwrite is True.

    Args:
        source: Source file path
        destination: Destination file path
        dry_run: If True, only simulate operations
        force_overwrite: If True, allow overwriting of existing destination files

    Returns:
        True if copy successful or simulated, False otherwise
    """
    # Check if source exists
    if not source.exists():
        error_msg = f"Source file does not exist: {source}"
        logger.error(error_msg)
        print_error(error_msg)
        return False

    # Check if destination already exists (never overwrite unless force_overwrite is True)
    if destination.exists():
        if not force_overwrite:
            error_msg = (
                f"Destination file already exists, will not overwrite: {destination}"
            )
        logger.error(error_msg)
        print_error(error_msg)
        return False
    else:
        warning_msg = f"Destination file exists, will overwrite: {destination}"
        logger.warning(warning_msg)
        print_warning(warning_msg)

    # Ensure parent directory exists
    ensure_directory_exists(destination.parent)

    # Perform the copy or simulate it
    if dry_run:
        action = "overwrite" if destination.exists() and force_overwrite else "copy"
        logger.info(f"[DRY RUN] Would {action}: {source} -> {destination}")
        print_info(f"[DRY RUN] Would {action}: {source} → {destination}")
        return True
    else:
        try:
            shutil.copy2(source, destination)
            success_msg = f"Successfully copied: {source} → {destination}"
            logger.info(success_msg)
            print_success(success_msg)
            return True
        except Exception as e:
            error_msg = f"Error copying file: {e}"
            logger.error(error_msg)
            print_error(error_msg)
            return False


def send_to_recycle_bin(file_path: Path, dry_run: bool = False) -> bool:
    """
    Move a file to the Windows recycle bin instead of permanently deleting it.

    Args:
        file_path: Path to the file to be moved to recycle bin
        dry_run: If True, only simulate operations

    Returns:
        True if successful or simulated, False otherwise
    """
    if not file_path.exists():
        error_msg = f"File does not exist, cannot move to recycle bin: {file_path}"
        logger.error(error_msg)
        print_error(error_msg)
        return False

    if dry_run:
        logger.info(f"[DRY RUN] Would move to recycle bin: {file_path}")
        print_info(f"[DRY RUN] Would move to recycle bin: {file_path}")
        return True

    try:
        # Use Windows API to send to recycle bin
        # Windows-specific code for sending to recycle bin
        if sys.platform == "win32":
            # Windows API constants
            fof_silent = 0x0004
            fof_noconfirmation = 0x0010
            fof_allowundo = 0x0040
            fof_noerrorui = 0x0400

            flags = fof_allowundo | fof_noconfirmation | fof_noerrorui | fof_silent

            # Fix: Convert the path to the correct format for SHFileOperation
            # The path needs to be double-null terminated
            file_path_str = str(file_path.absolute()) + "\0\0"

            # Create a SHFILEOPSTRUCT structure
            class SHFILEOPSTRUCT(ctypes.Structure):
                _fields_ = [
                    ("hwnd", ctypes.c_void_p),
                    ("wFunc", ctypes.c_uint),
                    ("pFrom", ctypes.c_wchar_p),  # This expects c_wchar_p
                    ("pTo", ctypes.c_wchar_p),
                    ("fFlags", ctypes.c_int),
                    ("fAnyOperationsAborted", ctypes.c_bool),
                    ("hNameMappings", ctypes.c_void_p),
                    ("lpszProgressTitle", ctypes.c_wchar_p),
                ]

            # FO_DELETE = 3
            file_op = SHFILEOPSTRUCT()
            file_op.wFunc = 3  # FO_DELETE
            file_op.pFrom = file_path_str  # Use the string directly instead of buffer
            file_op.fFlags = flags

            # Perform the operation
            shell32 = ctypes.windll.shell32
            result = shell32.SHFileOperationW(ctypes.byref(file_op))

            if result == 0:
                success_msg = f"Successfully moved to recycle bin: {file_path}"
                logger.info(success_msg)
                print_success(success_msg)
                return True
            else:
                error_msg = f"Error moving to recycle bin, error code: {result}"
                logger.error(error_msg)
                print_error(error_msg)
                return False
        else:
            # For non-Windows platforms (fallback to just reporting)
            warning_msg = f"Recycle bin operation not supported on this platform. Would delete: {file_path}"
            logger.warning(warning_msg)
            print_warning(warning_msg)
            return True

    except Exception as e:
        error_msg = f"Error moving file to recycle bin: {e}"
        logger.error(error_msg)
        print_error(error_msg)
        return False


def load_config(config_path: Path) -> dict[str, Any]:
    """
    Load and validate the configuration file.

    Args:
        config_path: Path to the JSON configuration file

    Returns:
        Parsed configuration dictionary
    """
    print_info(f"Loading configuration from: {config_path}")

    if not config_path.exists():
        error_msg = f"Configuration file does not exist: {config_path}"
        logger.error(error_msg)
        print_error(error_msg)
        sys.exit(1)

    try:
        with open(config_path, encoding="utf-8") as f:
            config = json.load(f)

        # Basic validation
        if "operations" not in config:
            error_msg = "Configuration must contain 'operations' key"
            logger.error(error_msg)
            print_error(error_msg)
            sys.exit(1)

        print_success(
            f"Successfully loaded configuration with {len(config['operations'])} operations"
        )
        return config
    except json.JSONDecodeError as e:
        error_msg = f"Error parsing JSON configuration: {e}"
        logger.error(error_msg)
        print_error(error_msg)
        sys.exit(1)
    except Exception as e:
        error_msg = f"Error loading configuration: {e}"
        logger.error(error_msg)
        print_error(error_msg)
        sys.exit(1)


def process_operation(
    operation: dict[str, str],
    dry_run: bool,
    root_dir: Path,
    force_overwrite: bool = False,
    organize_by_category: bool = False,
) -> bool:
    """
    Process a single file operation.

    Args:
        operation: Operation configuration dictionary
        dry_run: If True, only simulate operations
        root_dir: Root directory for resolving relative paths (memory-bank folder)
        force_overwrite: If True, allow overwriting of existing destination files
        organize_by_category: If True, organize files into category folders

    Returns:
        True if operation successful or simulated, False otherwise
    """
    # Get paths and resolve them relative to the memory-bank root directory
    source_path = root_dir / operation["source"]
    dest_folder = root_dir / operation["destination_folder"]

    # Get the filename from the source path
    filename = source_path.name

    # Determine destination path based on organization preference
    if organize_by_category and operation.get("operation_type") == "move":
        # Determine appropriate category based on file content/name
        category = operation.get("category", determine_file_category(source_path))
        # Create category folder structure
        category_folder = create_category_folder_structure(dest_folder, category)
        destination_path = category_folder / filename
    else:
        destination_path = dest_folder / filename

    # Log operation details
    if dry_run:
        print_header(f"DRY RUN: Processing operation for {filename}")
    else:
        print_header(f"Processing operation for {filename}")

    print_info(f"Source: {source_path}")
    print_info(f"Destination: {destination_path}")
    logger.info("Processing operation:")
    logger.info(f"  Source: {source_path}")
    logger.info(f"  Destination: {destination_path}")

    # Extract base name for version checking (strip extension)
    base_name = filename.split(".")[0] if "." in filename else filename

    # Remove version suffix if present for better matching
    if "_v" in base_name:
        search_base = base_name.split("_v")[0]
    else:
        search_base = base_name

    # Check for versioned files in root directory
    # Pattern matches: base_name_v1.1.md, base_name_v2.0.md, etc.
    versioned_files = list(root_dir.glob(f"{search_base}_v*.md"))

    if not versioned_files:
        print_warning(
            f"No versioned file found for {filename}. Make sure to create a versioned file before moving the original."
        )
    else:
        print_info(
            f"Found versioned file(s): {', '.join(f.name for f in versioned_files)}"
        )

    # Execute file copy
    return safe_copy_file(source_path, destination_path, dry_run, force_overwrite)


def verify_operation(operation: dict[str, str], root_dir: Path) -> bool:
    """
    Verify that a file operation was completed successfully.

    Args:
        operation: Operation configuration dictionary
        root_dir: Root directory for resolving relative paths

    Returns:
        True if verification passed, False otherwise
    """
    source_path = root_dir / operation["source"]
    dest_folder = root_dir / operation["destination_folder"]
    filename = source_path.name

    # Check if this is an organized operation with a category
    if operation.get("category"):
        category_folder = dest_folder / operation["category"]
        destination_path = category_folder / filename
    else:
        destination_path = dest_folder / filename

    if not destination_path.exists():
        print_error(f"Verification failed: {destination_path} does not exist")
        return False

    # Compare file sizes as a basic check
    source_size = source_path.stat().st_size
    dest_size = destination_path.stat().st_size

    if source_size != dest_size:
        print_error(f"Verification failed: File sizes don't match for {filename}")
        print_info(
            f"Source size: {source_size} bytes, Destination size: {dest_size} bytes"
        )
        return False

    print_success(f"Verification passed for {destination_path}")
    return True


def main() -> None:
    """Main entry point for the script."""
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description=textwrap.dedent(
            """
            Memory Manager - A tool for managing memory files.

            This tool helps organize and manage memory files by performing operations
            like copying and moving files to appropriate locations, and moving original
            files to the Windows recycle bin. It follows a structured workflow:

            1. VALIDATION/DRY RUN: Validates all operations without making changes
            2. FILE COPYING: Copies files to appropriate archival locations
            3. RECYCLE BIN: Moves original files to Windows recycle bin (with confirmation)

            The tool also supports organizing files into category folders in long-term memory,
            detecting categories based on file content and name, and reorganizing existing files.
            """
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "config_file", help="Path to the memory configuration JSON file"
    )
    parser.add_argument(
        "--force-overwrite",
        action="store_true",
        help="Force overwriting of existing files (USE WITH CAUTION)",
    )
    parser.add_argument(
        "--recycle-confirmed",
        action="store_true",
        help="Skip confirmations and only perform recycle bin operations (USE WITH CAUTION)",
    )

    # Add new organization arguments
    organization_group = parser.add_argument_group("Organization options")
    organization_group.add_argument(
        "--organize-by-category",
        action="store_true",
        help="Organize files into category folders in long-term memory",
    )
    organization_group.add_argument(
        "--reorganize-existing",
        action="store_true",
        help="Organize existing files in long-term memory into category folders",
    )
    organization_group.add_argument(
        "--analyze-organization",
        action="store_true",
        help="Analyze current organization without making changes",
    )
    organization_group.add_argument(
        "--category-detection",
        choices=["basic", "smart", "content-based"],
        default="smart",
        help="Method for detecting file categories (default: smart)",
    )

    args = parser.parse_args()

    # Set up logging
    configure_logging()
    global logger
    logger = logging.getLogger(__name__)

    print_header("MEMORY MANAGER SCRIPT")
    print_info("Starting memory management process...")

    # Log memory usage if available
    if PSUTIL_AVAILABLE:
        print_info(log_memory_usage())

    # Convert relative config path to absolute
    config_path = Path(args.config_file)
    if not config_path.is_absolute():
        config_path = Path.cwd() / config_path

    # Special case for recycle operation only
    if args.recycle_confirmed:
        print_warning(
            "RECYCLE CONFIRMATION FLAG DETECTED. Will only perform recycling bin operations."
        )
        print_warning(
            "This assumes you've previously run the script and confirmed all file copies."
        )
        print_warning(
            "Make sure versioned files exist in the root directory before proceeding."
        )

        # Load config
        config = load_config(config_path)

        # Use memory-bank root as the root directory instead of going up multiple levels
        root_dir = memory_bank_root
        logger.info(f"Using memory-bank root directory: {root_dir}")

        operations = config["operations"]
        recycling_success = process_recycling_operations(operations, root_dir, False)

        if recycling_success:
            print_success("Memory files successfully moved to recycling bin.")
            logger.info("Memory files successfully moved to recycling bin.")
            trigger_garbage_collection()
            sys.exit(0)
        else:
            print_error("Failed to move some files to recycling bin.")
            logger.error("Failed to move some files to recycling bin.")
            trigger_garbage_collection()
            sys.exit(1)
    # Check if organization analysis is requested
    elif args.analyze_organization:
        print_info("Analyzing current organization of long-term memory files...")
        config = load_config(config_path)

        # Use memory-bank root as the root directory
        root_dir = memory_bank_root
        ltm_dir = root_dir / "Bedtime Protocol" / "Long term memory"

        # Run the analysis without making changes
        analysis = analyze_long_term_memory(ltm_dir, args.category_detection)
        if analysis["status"] == "success":
            print_success("Organization analysis completed successfully.")
            trigger_garbage_collection()
            sys.exit(0)
        else:
            print_error("Organization analysis failed.")
            sys.exit(1)
    # Check if reorganization is requested
    elif args.reorganize_existing:
        print_info("Reorganizing existing files in long-term memory...")
        config = load_config(config_path)

        # Use memory-bank root as the root directory
        root_dir = memory_bank_root
        ltm_dir = root_dir / "Bedtime Protocol" / "Long term memory"

        # First perform a dry run
        print_header("Performing DRY RUN for reorganization")
        options = {
            "force_overwrite": args.force_overwrite,
            "create_metadata": True,
            "category_detection": args.category_detection,
        }

        analysis = analyze_long_term_memory(ltm_dir, args.category_detection)
        successful_dry_run, failed_dry_run = reorganize_existing_files(
            ltm_dir, analysis, True, options
        )

        if not successful_dry_run:
            print_info("No files to reorganize or all operations would fail.")
            sys.exit(0)

        # Ask for confirmation
        if not get_user_confirmation("Do you want to proceed with the reorganization?"):
            print_info("Reorganization cancelled by user.")
            sys.exit(0)

        # Perform the actual reorganization
        successful_ops, failed_ops = reorganize_existing_files(
            ltm_dir, analysis, False, options
        )

        # Update the storage log
        if successful_ops:
            update_storage_log_with_organization(ltm_dir, successful_ops)

        if failed_ops:
            print_warning(f"{len(failed_ops)} operations failed during reorganization.")
            logger.warning(
                f"{len(failed_ops)} operations failed during reorganization."
            )

        print_success(f"Successfully reorganized {len(successful_ops)} files.")
        trigger_garbage_collection()
        sys.exit(0 if not failed_ops else 1)

    # Normal workflow for memory management
    # Load config
    config = load_config(config_path)

    # Use memory-bank root as the root directory instead of going up multiple levels
    root_dir = memory_bank_root
    logger.info(f"Using memory-bank root directory: {root_dir}")

    operations = config["operations"]

    # Perform dry run of all operations first
    print_header("PERFORMING DRY RUN")
    dry_run_success = run_dry_run(
        operations,
        root_dir,
        args.force_overwrite,
        args.organize_by_category,
        args.category_detection,
    )

    if not dry_run_success:
        print_error("Dry run failed. Please fix the errors and try again.")
        logger.error("Dry run failed. Please fix the errors and try again.")
        trigger_garbage_collection()
        sys.exit(1)

    print_success("Dry run completed successfully.")
    logger.info("Dry run completed successfully.")

    # Ask for confirmation before proceeding with actual operations
    if not get_user_confirmation(
        "Do you want to proceed with the memory file operations?"
    ):
        print_info("Operations cancelled by user.")
        logger.info("Operations cancelled by user.")
        trigger_garbage_collection()
        sys.exit(0)

    # Perform all operations
    print_header("PERFORMING FILE COPYING OPERATIONS")
    ops_success = perform_operations(
        operations,
        root_dir,
        args.force_overwrite,
        args.organize_by_category,
        args.category_detection,
    )

    if not ops_success:
        print_error("Some operations failed. Please check the logs.")
        logger.error("Some operations failed. Please check the logs.")
        trigger_garbage_collection()
        sys.exit(1)

    print_success("All file copying operations completed successfully.")
    logger.info("All file copying operations completed successfully.")

    # Verify operations
    print_header("VERIFYING FILE COPYING OPERATIONS")
    verification_success = verify_operations(operations, root_dir)

    if not verification_success:
        print_error(
            "Some operations could not be verified. Please check the logs and investigate."
        )
        logger.error(
            "Some operations could not be verified. Please check the logs and investigate."
        )
        trigger_garbage_collection()
        sys.exit(1)

    print_success("All operations verified successfully.")
    logger.info("All operations verified successfully.")

    # If organizing by category, update the storage log
    if args.organize_by_category and ops_success:
        ltm_dir = root_dir / "Bedtime Protocol" / "Long term memory"
        operation_details = []
        for op in operations:
            if op.get("operation_type") == "move":
                # Create operation details for updating the log
                source_path = root_dir / op["source"]
                dest_folder = root_dir / op["destination_folder"]
                category = op.get(
                    "category",
                    determine_file_category(source_path, args.category_detection),
                )
                category_folder = dest_folder / category
                destination_path = category_folder / source_path.name

                operation_details.append(
                    {
                        "source": str(source_path),
                        "destination": str(destination_path),
                        "category": category,
                        "timestamp": datetime.now().isoformat(),
                        "status": "success",
                    }
                )

        # Update the storage log with organization details
        if operation_details:
            update_storage_log_with_organization(
                ltm_dir, operation_details, "bedtime-protocol"
            )

    # Ask for confirmation before recycling
    if not get_user_confirmation(
        "Do you want to move the original files to the recycle bin?"
    ):
        print_info("Recycling cancelled by user.")
        logger.info("Recycling cancelled by user.")
        print_info(
            "To complete the process later, run the script with the --recycle-confirmed flag."
        )
        trigger_garbage_collection()
        sys.exit(0)

    # Move original files to recycle bin
    print_header("MOVING ORIGINAL FILES TO RECYCLE BIN")
    recycling_success = process_recycling_operations(operations, root_dir, False)

    if not recycling_success:
        print_error("Some files could not be moved to the recycle bin.")
        logger.error("Some files could not be moved to the recycle bin.")
        print_info(
            "You may need to manually delete these files or run the script with the --recycle-confirmed flag."
        )
        trigger_garbage_collection()
        sys.exit(1)

    print_success("All original files successfully moved to recycle bin.")
    logger.info("All original files successfully moved to recycle bin.")
    print_success("Memory management process completed successfully.")
    logger.info("Memory management process completed successfully.")
    trigger_garbage_collection()
    sys.exit(0)


def run_dry_run(
    operations: list[dict[str, Any]],
    root_dir: Path,
    force_overwrite: bool,
    organize_by_category: bool,
    category_detection: str,
) -> bool:
    """
    Perform a dry run of all operations to check for potential issues.

    Args:
        operations: List of operations to perform
        root_dir: Root directory for resolving relative paths
        force_overwrite: If True, allow overwriting of existing files
        organize_by_category: If True, organize files into category folders
        category_detection: Method for detecting file categories

    Returns:
        True if all operations would succeed, False otherwise
    """
    print_info(f"Performing dry run of {len(operations)} operations...")
    logger.info(f"Performing dry run of {len(operations)} operations...")

    any_failure = False

    for operation in operations:
        if "operation_type" in operation and operation["operation_type"] == "move":
            if organize_by_category:
                # Add category information based on the file
                source_path = root_dir / operation["source"]
                if source_path.exists():
                    category = determine_file_category(source_path, category_detection)
                    operation["category"] = category
                    print_info(f"Detected category for {source_path.name}: {category}")
                else:
                    print_warning(f"Source file does not exist: {source_path}")
                    any_failure = True
                    continue
            else:
                print_warning(f"Source file does not exist: {source_path}")
                any_failure = True
                continue

        # Process the operation in dry run mode
        success = process_operation(
            operation, True, root_dir, force_overwrite, organize_by_category
        )
        if not success:
            any_failure = True

    if any_failure:
        print_warning("Some operations would fail.")
        logger.warning("Dry run: Some operations would fail.")
    else:
        print_success("All operations would succeed.")
        logger.info("Dry run: All operations would succeed.")

    return not any_failure


def perform_operations(
    operations: list[dict[str, Any]],
    root_dir: Path,
    force_overwrite: bool,
    organize_by_category: bool,
    category_detection: str,
) -> bool:
    """
    Perform all operations.

    Args:
        operations: List of operations to perform
        root_dir: Root directory for resolving relative paths
        force_overwrite: If True, allow overwriting of existing files
        organize_by_category: If True, organize files into category folders
        category_detection: Method for detecting file categories

    Returns:
        True if all operations succeeded, False otherwise
    """
    print_info(f"Performing {len(operations)} operations...")
    logger.info(f"Performing {len(operations)} operations...")

    any_failure = False

    for i, operation in enumerate(operations):
        if "operation_type" in operation and operation["operation_type"] == "move":
            if organize_by_category:
                # Add category information based on the file
                source_path = root_dir / operation["source"]
                if source_path.exists():
                    category = determine_file_category(source_path, category_detection)
                    operation["category"] = category
                    print_info(f"Using category for {source_path.name}: {category}")
                else:
                    print_warning(f"Source file does not exist: {source_path}")
                    any_failure = True
                    continue

        # Process the operation
        success = process_operation(
            operation, False, root_dir, force_overwrite, organize_by_category
        )
        if not success:
            any_failure = True

        # Free up memory periodically
        if (i + 1) % 5 == 0:
            trigger_garbage_collection()

    if any_failure:
        print_warning("Some operations failed.")
        logger.warning("Some operations failed.")
    else:
        print_success("All operations succeeded.")
        logger.info("All operations succeeded.")

    return not any_failure


def verify_operations(operations: list[dict[str, Any]], root_dir: Path) -> bool:
    """
    Verify all operations were completed successfully.

    Args:
        operations: List of operations to verify
        root_dir: Root directory for resolving relative paths

    Returns:
        True if all operations verified successfully, False otherwise
    """
    print_info(f"Verifying {len(operations)} operations...")
    logger.info(f"Verifying {len(operations)} operations...")

    any_failure = False

    for operation in operations:
        if "operation_type" not in operation:
            continue

        # Only verify file copy operations
        if operation["operation_type"] == "move":
            success = verify_operation(operation, root_dir)
            if not success:
                any_failure = True

    if any_failure:
        print_warning("Some operations could not be verified.")
        logger.warning("Some operations could not be verified.")
    else:
        print_success("All operations verified successfully.")
        logger.info("All operations verified successfully.")

    return not any_failure


def process_recycling_operations(
    operations: list[dict[str, Any]], root_dir: Path, dry_run: bool
) -> bool:
    """
    Process recycling operations, moving original files to the recycle bin.

    Args:
        operations: List of operations to process
        root_dir: Root directory for resolving relative paths
        dry_run: If True, only simulate operations

    Returns:
        True if all recycling operations succeeded, False otherwise
    """
    print_info(f"Processing {len(operations)} recycling operations...")
    logger.info(f"Processing {len(operations)} recycling operations...")

    any_failure = False

    for operation in operations:
        if "operation_type" not in operation:
            continue

        # Only move files to recycle bin for file copy operations
        if operation["operation_type"] == "move":
            source_path = root_dir / operation["source"]

            # Check if source exists before attempting to recycle
            if not source_path.exists():
                print_warning(f"Source file does not exist, skipping: {source_path}")
                logger.warning(f"Source file does not exist, skipping: {source_path}")
                continue

            # Send to recycle bin
            success = send_to_recycle_bin(source_path, dry_run)
            if not success:
                any_failure = True

    if any_failure:
        print_warning("Some files could not be moved to the recycle bin.")
        logger.warning("Some files could not be moved to the recycle bin.")
    else:
        print_success("All files successfully moved to the recycle bin.")
        logger.info("All files successfully moved to the recycle bin.")

    return not any_failure


def configure_logging() -> None:
    """Configure logging for the script."""
    global logs_dir

    # Create logs directory if it doesn't exist
    if not logs_dir.exists():
        logs_dir.mkdir(parents=True, exist_ok=True)

    # Set up logging configuration
    log_file = (
        logs_dir / f"memory_manager_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
    )

    # Configure root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)

    # Create file handler
    file_handler = RotatingFileHandler(
        log_file, maxBytes=1024 * 1024 * 5, backupCount=3
    )
    file_handler.setLevel(logging.INFO)

    # Create console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.WARNING)  # Only warnings and errors to console

    # Create formatter
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    file_handler.setFormatter(formatter)
    console_handler.setFormatter(formatter)

    # Add handlers to root logger
    root_logger.addHandler(file_handler)
    root_logger.addHandler(console_handler)

    # Log starting message
    logger.info("=" * 80)
    logger.info("Memory Manager Script Started")
    logger.info(f"Log file: {log_file}")
    logger.info("=" * 80)


if __name__ == "__main__":
    main()
