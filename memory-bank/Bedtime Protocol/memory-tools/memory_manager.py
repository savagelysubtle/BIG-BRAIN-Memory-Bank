#!/usr/bin/env python3
"""
Memory Manager Script - BIG BRAIN Bedtime Protocol

This script safely manages memory files by:
1. First performing a mandatory dry run to preview changes
2. Copying active files to appropriate archive locations
3. Requesting confirmation that files were correctly copied
4. Moving original files to the Windows recycle bin (never permanently deleting)

The script assumes that new versioned files have already been created in the active
directories and will archive previous versions.

Key features:
- Supports the BIG BRAIN Memory Bank system structure
- Organizes files into memory types (core, semantic, episodic, procedural)
- Maintains hierarchical organization within memory types
- Preserves version history with smart archiving
- Maintains detailed log of organizational structure
- AI-assistant friendly with non-interactive mode

Usage:
    python memory_manager.py [config_file] [--force-overwrite]
    python memory_manager.py [config_file] [--recycle-confirmed]
    python memory_manager.py [config_file] [--organize-by-category]
    python memory_manager.py [config_file] [--reorganize-existing]
    python memory_manager.py [config_file] [--analyze-organization]
    python memory_manager.py [config_file] [--non-interactive] [--report-file REPORT_FILE]
    python memory_manager.py [config_file] [--mode {plan,act,auto}]
    python memory_manager.py [config_file] [--auto-version]

Arguments:
    config_file          Path to the memory configuration JSON file (default: memory_config.json)
    --force-overwrite    Allow overwriting of existing files (USE WITH CAUTION)
    --recycle-confirmed  Skip confirmations and only perform recycling bin operations (USE WITH CAUTION)
    --organize-by-category   Organize files into category folders in archive directories
    --reorganize-existing    Organize existing files in archive directories into category folders
    --analyze-organization   Analyze current organization without making changes
    --category-detection     Method for detecting file categories (basic, smart, content-based)
    --non-interactive        Run all operations without prompting for confirmation (for AI assistants)
    --report-file            Path to write operation report (useful with --non-interactive)
    --mode                   Operation mode: plan (analyze only), act (perform operations), auto (determine from activeContext.md)
    --auto-version           Automatically create versioned copies of files before archiving
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
from collections.abc import Callable
from datetime import datetime
from logging.handlers import RotatingFileHandler
from pathlib import Path
from typing import Any, TypeVar

try:
    import psutil  # type: ignore

    PSUTIL_AVAILABLE = True
except ImportError:
    PSUTIL_AVAILABLE = False
    print("Note: psutil not available. Memory usage monitoring disabled.")

try:
    import markdown  # type: ignore

    MARKDOWN_AVAILABLE = True
except ImportError:
    MARKDOWN_AVAILABLE = False
    print("Note: markdown package not available. Some formatting features disabled.")

try:
    import concurrent.futures  # type: ignore

    CONCURRENT_AVAILABLE = True
except ImportError:
    CONCURRENT_AVAILABLE = False
    print(
        "Note: concurrent.futures not available. Some parallel processing features disabled."
    )

try:
    import fnmatch  # type: ignore

    FNMATCH_AVAILABLE = True
except ImportError:
    FNMATCH_AVAILABLE = (
        True  # Built into Python standard library, should always be available
    )

# Define constants
MEMORY_TYPES = ["core", "episodic", "semantic", "procedural"]


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


# Error handling helper functions
T = TypeVar("T")


def handle_exception(e: Exception, error_msg: str, log_error: bool = True) -> None:
    """
    Centralized exception handler to maintain consistent error handling.

    Args:
        e: The caught exception
        error_msg: Error message to display and log
        log_error: Whether to log the error message (default: True)
    """
    full_msg = f"{error_msg}: {e}"
    print_error(full_msg)
    if log_error and "logger" in globals():
        logger.error(full_msg)


def safe_operation(
    operation: Callable[..., T], error_msg: str, *args, **kwargs
) -> T | None:
    """
    Execute an operation safely with exception handling.

    Args:
        operation: Function to execute
        error_msg: Error message if the operation fails
        *args: Arguments for the operation
        **kwargs: Keyword arguments for the operation

    Returns:
        The result of the operation or None if it fails
    """
    try:
        return operation(*args, **kwargs)
    except Exception as e:
        handle_exception(e, error_msg)
        return None


def safe_file_operation(
    operation: Callable[..., T], file_path: Path, error_prefix: str, *args, **kwargs
) -> T | None:
    """
    Execute a file operation safely with standardized error handling.

    Args:
        operation: Function that performs the file operation
        file_path: Path to the file being operated on
        error_prefix: Prefix for the error message (e.g. "Error reading file")
        *args: Additional arguments for the operation
        **kwargs: Additional keyword arguments for the operation

    Returns:
        The result of the operation or None if it fails
    """
    try:
        return operation(*args, **kwargs)
    except Exception as e:
        handle_exception(e, f"{error_prefix}: {file_path}")
        return None


# Find memory-bank root directory
def find_memory_bank_root() -> Path:
    """
    Find the memory-bank root directory

    Since the script location is fixed, this function provides a direct path
    to the memory-bank folder without needing complex traversal logic.
    """
    # Get the script directory
    script_path = Path(os.path.dirname(os.path.abspath(__file__)))

    # In BIG BRAIN structure, the memory-bank folder is always two levels up from the script
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


def get_user_confirmation(prompt: str, non_interactive: bool = False) -> bool:
    """
    Get confirmation from the user or auto-confirm if in non-interactive mode.

    Args:
        prompt: The confirmation prompt to display
        non_interactive: If True, automatically confirm without user input

    Returns:
        True if confirmed, False otherwise
    """
    if non_interactive:
        print_info(f"{prompt} [AUTO-CONFIRMED in non-interactive mode]")
        logger.info(f"Auto-confirmed: {prompt}")
        return True

    # Original interactive confirmation code
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


def determine_memory_type(file_path: Path, detection_method: str = "smart") -> str:
    """
    Determine the memory type (core, episodic, semantic, procedural) for a file.

    Args:
        file_path: Path to the file
        detection_method: Method for detection ('basic', 'smart', 'content-based')

    Returns:
        Memory type name as string
    """
    # Extract path components
    path_parts = file_path.parts

    # If the path explicitly contains a memory type directory, use that
    for part in path_parts:
        if part.lower() in MEMORY_TYPES:
            return part.lower()

    # If detection method is basic, try to determine from filename
    base_name = file_path.stem.lower()

    # Core memory files
    if any(
        name in base_name
        for name in [
            "projectbrief",
            "productcontext",
            "activecontext",
            "systempatterns",
            "techcontext",
            "progress",
            "projectrules",
        ]
    ):
        return "core"

    # Episodic memory files
    if any(
        name in base_name
        for name in ["session", "decision", "implementation", "history"]
    ):
        return "episodic"

    # Semantic memory files
    if any(name in base_name for name in ["domain", "feature", "concept", "pattern"]):
        return "semantic"

    # Procedural memory files
    if any(
        name in base_name
        for name in ["workflow", "guide", "process", "setup", "deployment"]
    ):
        return "procedural"

    # Default to core if we can't determine
    return "core"


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

    # BIG BRAIN specific categorization
    # Get memory type to help with categorization
    memory_type = determine_memory_type(file_path)

    # Extract base name without version
    if "_v" in base_name:
        base_name = base_name.split("_v")[0]

    # Core memory files - use exact names
    if memory_type == "core":
        core_files = [
            "projectbrief",
            "productcontext",
            "activecontext",
            "systempatterns",
            "techcontext",
            "progress",
            "projectrules",
        ]
        for file in core_files:
            if file.lower() in base_name.lower():
                return file

    # For other memory types, use categories from the config
    # These would be populated from memory_config.json
    categories = {
        "episodic": ["sessions", "decisions", "implementation", "history"],
        "semantic": ["domain", "features", "concepts", "patterns"],
        "procedural": ["workflows", "guides", "processes", "setup"],
    }

    if memory_type in categories:
        for category in categories[memory_type]:
            if category.lower() in base_name.lower():
                return category

    # If content-based detection is requested and we couldn't determine from filename
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

            # Define content-based keywords for each memory type
            content_keywords = {
                "core": {
                    "projectbrief": [
                        "project brief",
                        "project overview",
                        "project goals",
                    ],
                    "productContext": [
                        "product context",
                        "user experience",
                        "business logic",
                    ],
                    "activeContext": [
                        "active context",
                        "current focus",
                        "current work",
                    ],
                    "systemPatterns": ["system patterns", "architecture", "components"],
                    "techContext": [
                        "tech context",
                        "technology stack",
                        "development environment",
                    ],
                    "progress": ["progress", "milestone", "completion", "status"],
                    "projectRules": [
                        "project rules",
                        "patterns",
                        "conventions",
                        "preferences",
                    ],
                },
                "episodic": {
                    "sessions": [
                        "session summary",
                        "session log",
                        "during the session",
                    ],
                    "decisions": ["decision record", "chose to", "decided to"],
                    "implementation": ["implementation", "was built", "was developed"],
                    "history": ["history", "timeline", "chronology", "evolution"],
                },
                "semantic": {
                    "domain": ["domain", "business concept", "entity", "model"],
                    "features": [
                        "feature",
                        "functionality",
                        "capability",
                        "user story",
                    ],
                    "concepts": ["concept", "idea", "principle", "theory"],
                    "patterns": ["pattern", "approach", "solution", "design pattern"],
                },
                "procedural": {
                    "workflows": ["workflow", "process flow", "sequence", "stages"],
                    "guides": ["guide", "how to", "instruction", "step by step"],
                    "processes": ["process", "procedure", "operation", "method"],
                    "setup": ["setup", "installation", "configuration", "environment"],
                },
            }

            if memory_type in content_keywords:
                for category, keywords in content_keywords[memory_type].items():
                    if any(keyword in content_lower for keyword in keywords):
                        return category
        except Exception as e:
            logger.warning(f"Error reading file for content-based categorization: {e}")

    # If we still couldn't determine a category, use the base name
    return base_name.lower()


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
    print_header("ANALYZING MEMORY ORGANIZATION")

    if not ltm_dir.exists():
        print_error(f"Memory directory does not exist: {ltm_dir}")
        return {
            "status": "error",
            "message": f"Directory does not exist: {ltm_dir}",
            "loose_files": [],
            "categories": {},
            "recommended_actions": [],
        }

    # For BIG BRAIN Memory Bank, analyze each memory type directory
    memory_analysis = {}

    for memory_type in MEMORY_TYPES:
        memory_dir = ltm_dir / memory_type / "archive"
        if not memory_dir.exists():
            memory_analysis[memory_type] = {
                "status": "missing",
                "message": f"Directory does not exist: {memory_dir}",
                "loose_files": [],
                "categories": {},
            }
            continue

        # Find all markdown files directly in the archive directory
        loose_files = [f for f in memory_dir.glob("*.md") if f.is_file()]
        loose_file_paths = [str(f.relative_to(memory_dir)) for f in loose_files]

        # Find existing category folders
        existing_categories = {}
        for item in memory_dir.iterdir():
            if item.is_dir():
                category_name = item.name
                files_in_category = list(item.glob("*.md"))
                existing_categories[category_name] = {
                    "path": str(item.relative_to(memory_dir)),
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
            file_categories[category].append(str(file_path.relative_to(memory_dir)))

        # Prepare summary
        total_files = len(loose_files) + sum(
            cat["file_count"] for cat in existing_categories.values()
        )

        memory_analysis[memory_type] = {
            "status": "success",
            "loose_files": loose_file_paths,
            "loose_file_count": len(loose_files),
            "categories": existing_categories,
            "category_count": len(existing_categories),
            "total_files": total_files,
            "organization_percentage": 100 - (len(loose_files) / total_files * 100)
            if total_files > 0
            else 0,
            "file_categories": file_categories,
        }

    # Generate recommendations
    recommendations = []

    for memory_type, analysis in memory_analysis.items():
        if analysis["status"] == "missing":
            recommendations.append(
                {
                    "type": "create_directory",
                    "description": f"Create archive directory for {memory_type} memory",
                    "memory_type": memory_type,
                }
            )
            continue

        if analysis["loose_files"]:
            recommendations.append(
                {
                    "type": "organize_loose_files",
                    "description": f"Organize {len(analysis['loose_files'])} loose files in {memory_type} memory",
                    "memory_type": memory_type,
                    "details": analysis["file_categories"],
                }
            )

        for category_name, category_info in analysis["categories"].items():
            if not category_info["has_metadata"]:
                recommendations.append(
                    {
                        "type": "add_category_metadata",
                        "description": f"Add metadata to category folder: {memory_type}/{category_name}",
                        "memory_type": memory_type,
                        "category": category_name,
                    }
                )

    # Combine all analyses into one result
    combined_result = {
        "status": "success",
        "timestamp": datetime.now().isoformat(),
        "memory_types": memory_analysis,
        "recommended_actions": recommendations,
    }

    # Print summary
    for memory_type, analysis in memory_analysis.items():
        if analysis["status"] == "missing":
            print_warning(
                f"{memory_type.capitalize()} memory archive directory does not exist"
            )
            continue

        print_info(f"\n{memory_type.capitalize()} Memory:")
        print_info(
            f"  Found {analysis['loose_file_count']} loose files needing organization"
        )
        print_info(f"  Found {analysis['category_count']} existing category folders")
        print_info(f"  Total files: {analysis['total_files']}")

        if analysis["loose_files"]:
            print_info(f"\n  Proposed categorization for {memory_type}:")
            for category, files in analysis["file_categories"].items():
                print_info(f"    {category}: {len(files)} files")

    if recommendations:
        print_info("\nRecommended actions:")
        for rec in recommendations:
            print_info(f"  - {rec['description']}")

    return combined_result


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

    return (
        safe_file_operation(
            _update_storage_log_content,
            log_file,
            "Error updating storage log",
            log_file,
            operations,
            organization_type,
        )
        is not None
    )


def _update_storage_log_content(
    log_file: Path, operations: list[dict[str, Any]], organization_type: str
) -> bool:
    """
    Internal function to update storage log content - separated to use with safe_file_operation.
    """
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
        return (
            safe_operation(
                _perform_copy,
                f"Error copying file from {source} to {destination}",
                source,
                destination,
            )
            is not None
        )


def _perform_copy(source: Path, destination: Path) -> bool:
    """Internal function to perform file copy operation."""
    shutil.copy2(source, destination)
    success_msg = f"Successfully copied: {source} → {destination}"
    logger.info(success_msg)
    print_success(success_msg)
    return True


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

    # Use Windows API to send to recycle bin
    if sys.platform == "win32":
        return (
            safe_operation(
                _send_to_windows_recycle_bin,
                f"Error moving file to recycle bin: {file_path}",
                file_path,
            )
            is not None
        )
    else:
        # For non-Windows platforms (fallback to just reporting)
        warning_msg = f"Recycle bin operation not supported on this platform. Would delete: {file_path}"
        logger.warning(warning_msg)
        print_warning(warning_msg)
        return True


def _send_to_windows_recycle_bin(file_path: Path) -> bool:
    """Internal function to send a file to the Windows recycle bin."""
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

    config = safe_file_operation(
        _load_and_validate_config,
        config_path,
        "Error loading configuration",
        config_path,
    )

    if config is None:
        sys.exit(1)

    return config


def _load_and_validate_config(config_path: Path) -> dict[str, Any]:
    """Internal function to load and validate config file."""
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

    # Get memory type from operation or determine it
    memory_type = operation.get("memory_type", determine_memory_type(source_path))

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

    # For BIG BRAIN Memory Bank, check for newer versions in active directories
    # Depending on memory type, look in the appropriate active directory
    search_paths = []
    if memory_type == "core":
        search_paths.append(root_dir / "core" / "active")
    elif memory_type == "episodic":
        search_paths.append(root_dir / "episodic" / "active")
    elif memory_type == "semantic":
        search_paths.append(root_dir / "semantic" / "active")
    elif memory_type == "procedural":
        search_paths.append(root_dir / "procedural" / "active")
    else:
        # Fallback: search all active directories
        search_paths = [
            root_dir / "core" / "active",
            root_dir / "episodic" / "active",
            root_dir / "semantic" / "active",
            root_dir / "procedural" / "active",
        ]

    # Check each search path for versioned files
    versioned_files = []
    for search_path in search_paths:
        if search_path.exists():
            # Pattern matches: base_name_v1.1.md, base_name_v2.0.md, etc.
            versioned_files.extend(list(search_path.glob(f"{search_base}_v*.md")))
            # Also look for exact filename matches
            exact_match = search_path / f"{search_base}.md"
            if exact_match.exists():
                versioned_files.append(exact_match)

    if not versioned_files:
        print_warning(
            f"No versioned file found for {filename}. Make sure to create a new version before moving the original."
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

            The tool also supports organizing files into category folders, detecting
            categories based on file content and name, and reorganizing existing files.

            AI ASSISTANT SUPPORT: Use --non-interactive mode with --report-file for AI assistants.
            """
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    parser.add_argument(
        "config_file",
        nargs="?",
        default="memory_config.json",
        help="Path to the memory configuration JSON file (default: memory_config.json)",
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
        help="Organize files into category folders in archive directories",
    )
    organization_group.add_argument(
        "--reorganize-existing",
        action="store_true",
        help="Organize existing files in archive directories into category folders",
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

    # Add new AI assistant friendly options
    ai_assistant_group = parser.add_argument_group("AI assistant options")
    ai_assistant_group.add_argument(
        "--non-interactive",
        action="store_true",
        help="Run all operations without prompting for confirmation (for AI assistants)",
    )
    ai_assistant_group.add_argument(
        "--report-file",
        type=str,
        help="Path to write operation report (useful with --non-interactive)",
    )
    ai_assistant_group.add_argument(
        "--mode",
        choices=["plan", "act", "auto"],
        default="auto",
        help="Operation mode: plan (analyze only), act (perform operations), auto (determine from activeContext.md)",
    )
    ai_assistant_group.add_argument(
        "--auto-version",
        action="store_true",
        help="Automatically create versioned copies of files before archiving",
    )
    ai_assistant_group.add_argument(
        "--auto-detect",
        action="store_true",
        help="Automatically detect files to archive (ignores config file operations)",
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

    # Determine workflow mode
    workflow_mode = args.mode
    if workflow_mode == "auto":
        workflow_mode = determine_workflow_mode(memory_bank_root)

    print_info(f"Operating in {workflow_mode.upper()} mode")
    logger.info(f"Operating in {workflow_mode.upper()} mode")

    # If in plan mode and not specifically requested to perform operations,
    # override to non-interactive and skip recycle bin operations
    if workflow_mode == "plan" and not args.recycle_confirmed:
        if not args.non_interactive:
            print_info(
                "PLAN mode enabled: Running in analysis mode only (no file changes)"
            )
        args.non_interactive = True
        args.skip_recycle = True
    else:
        args.skip_recycle = False

    # Special case for recycle operation only
    if args.recycle_confirmed:
        print_warning(
            "RECYCLE CONFIRMATION FLAG DETECTED. Will only perform recycling bin operations."
        )
        print_warning(
            "This assumes you've previously run the script and confirmed all file copies."
        )
        print_warning(
            "Make sure versioned files exist in the active directories before proceeding."
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
        print_info("Analyzing current organization of memory files...")
        config = load_config(config_path)

        # Use memory-bank root as the root directory
        root_dir = memory_bank_root

        # Analyze each memory type
        all_analyses = {}

        for memory_type in MEMORY_TYPES:
            memory_dir = root_dir / memory_type
            if not memory_dir.exists():
                print_warning(
                    f"{memory_type.capitalize()} memory directory does not exist: {memory_dir}"
                )
                continue

            archive_dir = memory_dir / "archive"
            if not archive_dir.exists():
                print_warning(
                    f"{memory_type.capitalize()} archive directory does not exist: {archive_dir}"
                )
                continue

            analysis = analyze_long_term_memory(archive_dir, args.category_detection)
            if analysis["status"] == "success":
                all_analyses[memory_type] = analysis

        # Generate a report
        if args.report_file:
            report_content = "# Memory Organization Analysis Report\n\n"
            report_content += (
                f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
            )

            for memory_type, analysis in all_analyses.items():
                report_content += f"## {memory_type.capitalize()} Memory\n\n"
                report_content += f"- **Loose Files:** {analysis['loose_file_count']}\n"
                report_content += f"- **Categories:** {analysis['category_count']}\n"
                report_content += f"- **Total Files:** {analysis['total_files']}\n"
                report_content += f"- **Organization:** {analysis['organization_percentage']:.1f}%\n\n"

                if analysis["loose_file_count"] > 0:
                    report_content += "### Recommended Categorization\n\n"
                    report_content += "| Category | File Count |\n"
                    report_content += "|----------|------------|\n"

                    for category, files in analysis["file_categories"].items():
                        report_content += f"| {category} | {len(files)} |\n"

                report_content += "\n"

            # Write report
            try:
                with open(args.report_file, "w", encoding="utf-8") as f:
                    f.write(report_content)
                print_success(f"Analysis report written to {args.report_file}")
            except Exception as e:
                print_error(f"Error writing analysis report: {e}")

        print_success("Organization analysis completed successfully.")
        trigger_garbage_collection()
        sys.exit(0)
    # Check if reorganization is requested
    elif args.reorganize_existing:
        print_info("Reorganizing existing files in archive directories...")
        config = load_config(config_path)

        # Use memory-bank root as the root directory
        root_dir = memory_bank_root

        # Process each memory type
        all_successful_ops = []
        all_failed_ops = []

        for memory_type in MEMORY_TYPES:
            archive_dir = root_dir / memory_type / "archive"
            if not archive_dir.exists():
                print_warning(
                    f"{memory_type.capitalize()} archive directory does not exist: {archive_dir}"
                )
                continue

            # First perform a dry run
            print_header(f"Performing DRY RUN for {memory_type} reorganization")
            options = {
                "force_overwrite": args.force_overwrite,
                "create_metadata": True,
                "category_detection": args.category_detection,
            }

            analysis = analyze_long_term_memory(archive_dir, args.category_detection)
            successful_dry_run, failed_dry_run = reorganize_existing_files(
                archive_dir, analysis, True, options
            )

            if not successful_dry_run:
                print_info(
                    f"No {memory_type} files to reorganize or all operations would fail."
                )
                continue

            # Ask for confirmation unless in non-interactive mode
            if not get_user_confirmation(
                f"Do you want to proceed with the {memory_type} reorganization?",
                args.non_interactive,
            ):
                print_info(f"{memory_type.capitalize()} reorganization cancelled.")
                continue

            # Perform the actual reorganization
            successful_ops, failed_ops = reorganize_existing_files(
                archive_dir, analysis, False, options
            )

            all_successful_ops.extend(successful_ops)
            all_failed_ops.extend(failed_ops)

            # Update the storage log
            if successful_ops:
                update_storage_log_with_organization(archive_dir, successful_ops)

            if failed_ops:
                print_warning(
                    f"{len(failed_ops)} operations failed during {memory_type} reorganization."
                )
                logger.warning(
                    f"{len(failed_ops)} operations failed during {memory_type} reorganization."
                )

            print_success(
                f"Successfully reorganized {len(successful_ops)} {memory_type} files."
            )

        # Generate report if requested
        if args.report_file:
            combined_ops = all_successful_ops + all_failed_ops
            report = generate_operation_report(
                combined_ops, all_successful_ops, all_failed_ops, Path(args.report_file)
            )

        trigger_garbage_collection()
        sys.exit(0 if not all_failed_ops else 1)

    # Normal workflow for memory management
    # Load config or auto-detect files
    if args.auto_detect:
        print_info("Auto-detecting files to archive...")
        operations = auto_detect_files_to_archive()
        if not operations:
            print_info("No files detected for archiving.")
            sys.exit(0)
        print_info(f"Detected {len(operations)} files to archive.")
    else:
        # Load config
        if not config_path.exists():
            print_error(f"Configuration file does not exist: {config_path}")
            sys.exit(1)

        try:
            config = load_config(config_path)
            operations = config["operations"]
        except Exception as e:
            print_error(f"Error loading configuration: {e}")
            sys.exit(1)

    # Use memory-bank root as the root directory instead of going up multiple levels
    root_dir = memory_bank_root
    logger.info(f"Using memory-bank root directory: {root_dir}")

    # Auto-version files if requested
    if args.auto_version:
        print_header("CREATING VERSIONED COPIES")
        for operation in operations:
            if operation.get("operation_type") == "move":
                source_path = root_dir / operation["source"]
                memory_type = operation.get(
                    "memory_type", determine_memory_type(source_path)
                )

                if source_path.exists():
                    versioned_path = create_versioned_file(
                        source_path, memory_type, True, root_dir
                    )
                    if versioned_path:
                        print_success(f"Created versioned copy: {versioned_path}")
                    else:
                        print_error(
                            f"Failed to create versioned copy for: {source_path}"
                        )

    # In PLAN mode without specific override, we only analyze and don't modify files
    if workflow_mode == "plan" and not args.recycle_confirmed:
        print_header("PLAN MODE: ANALYZING OPERATIONS")

        # Generate dry run report
        report = generate_operation_report(operations, None, None)
        print_info("Operation plan generated")

        if args.report_file:
            try:
                with open(args.report_file, "w", encoding="utf-8") as f:
                    f.write(report)
                print_success(f"Operation plan written to {args.report_file}")
            except Exception as e:
                print_error(f"Error writing operation plan: {e}")

        print_success("Plan mode analysis completed.")
        print_info("To execute these operations, run again with --mode act")
        sys.exit(0)

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
        "Do you want to proceed with the memory file operations?", args.non_interactive
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

    # Skip recycling bin operations if in PLAN mode or explicitly skipped
    if args.skip_recycle:
        print_info("Skipping recycling bin operations.")
        logger.info("Skipping recycling bin operations.")
        print_info("To move files to recycling bin, run with --recycle-confirmed flag.")

        # Generate report if requested
        if args.report_file:
            # Get successful operations
            successful_ops = [
                {
                    "source": str(root_dir / operation["source"]),
                    "destination": str(
                        root_dir
                        / operation["destination_folder"]
                        / (
                            operation.get("source", "").split("/")[-1]
                            if operation.get("source")
                            else "unknown"
                        )
                    ),
                    "memory_type": operation.get("memory_type", "unknown"),
                    "description": operation.get("description", ""),
                    "status": "success",
                }
                for operation in operations
            ]

            report = generate_operation_report(
                operations, successful_ops, [], Path(args.report_file)
            )

        trigger_garbage_collection()
        sys.exit(0)

    # Ask for confirmation before recycling
    if not get_user_confirmation(
        "Do you want to move the original files to the recycle bin?",
        args.non_interactive,
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

    # Generate final report if requested
    if args.report_file:
        # Get successful operations
        successful_ops = [
            {
                "source": str(root_dir / operation["source"]),
                "destination": str(
                    root_dir
                    / operation["destination_folder"]
                    / (
                        operation.get("source", "").split("/")[-1]
                        if operation.get("source")
                        else "unknown"
                    )
                ),
                "memory_type": operation.get("memory_type", "unknown"),
                "description": operation.get("description", ""),
                "status": "success",
                "recycled": True,
            }
            for operation in operations
        ]

        report = generate_operation_report(
            operations, successful_ops, [], Path(args.report_file)
        )

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


def determine_workflow_mode(memory_bank_root: Path) -> str:
    """
    Determine the current workflow mode (PLAN or ACT) from activeContext.md.

    Args:
        memory_bank_root: Path to the memory bank root directory

    Returns:
        Workflow mode as string ("plan" or "act")
    """
    active_context_path = memory_bank_root / "core" / "active" / "activeContext.md"
    if not active_context_path.exists():
        logger.warning("activeContext.md not found, defaulting to PLAN mode")
        return "plan"

    try:
        with open(active_context_path, encoding="utf-8") as f:
            content = f.read().lower()

        if (
            "mode: plan" in content
            or "workflow: plan" in content
            or "in plan mode" in content
        ):
            logger.info("Detected PLAN mode from activeContext.md")
            return "plan"
        elif (
            "mode: act" in content
            or "workflow: act" in content
            or "in act mode" in content
        ):
            logger.info("Detected ACT mode from activeContext.md")
            return "act"
        else:
            logger.warning(
                "Could not determine mode from activeContext.md, defaulting to PLAN mode"
            )
            return "plan"
    except Exception as e:
        logger.error(f"Error reading activeContext.md: {e}")
        return "plan"


def create_versioned_file(
    source_path: Path,
    memory_type: str,
    version_increment: bool = True,
    root_dir: Path | None = None,
) -> Path | None:
    """
    Create a versioned copy of a source file in the appropriate active directory.

    Args:
        source_path: Path to the source file
        memory_type: Memory type (core, episodic, semantic, procedural)
        version_increment: If True, increment version number
        root_dir: Root directory of the memory bank

    Returns:
        Path to the created versioned file or None if operation failed
    """
    if root_dir is None:
        root_dir = memory_bank_root

    # Ensure the file exists
    if not source_path.exists():
        logger.error(f"Source file does not exist: {source_path}")
        return None

    # Extract base name and determine current version
    base_name = source_path.stem
    extension = source_path.suffix

    # Parse current version if present
    current_version = None
    if "_v" in base_name:
        base_parts = base_name.split("_v")
        base_name = base_parts[0]
        try:
            version_str = base_parts[1]
            if version_str:  # Check if version_str is not None or empty
                version_parts = version_str.split(".")
                if len(version_parts) == 2:
                    current_version = (int(version_parts[0]), int(version_parts[1]))
                else:
                    current_version = (int(version_parts[0]), 0)
        except (ValueError, IndexError):
            current_version = None

    # Determine new version
    if current_version is None:
        new_version = (1, 0)  # Start at v1.0
    elif version_increment:
        new_version = (
            current_version[0],
            current_version[1] + 1,
        )  # Increment minor version
    else:
        new_version = current_version  # Keep same version

    # Create new filename with version
    new_filename = f"{base_name}_v{new_version[0]}.{new_version[1]}{extension}"

    # Determine target directory
    target_dir = root_dir / memory_type / "active"
    ensure_directory_exists(target_dir)

    # Create the target path
    target_path = target_dir / new_filename

    # Copy the file
    return safe_file_operation(
        _create_versioned_copy,
        source_path,
        "Error creating versioned file",
        source_path,
        target_path,
    )


def _create_versioned_copy(source_path: Path, target_path: Path) -> Path:
    """Internal function to create a versioned copy of a file."""
    shutil.copy2(source_path, target_path)
    logger.info(f"Created versioned file: {target_path}")
    print_success(f"Created versioned file: {target_path}")
    return target_path


def auto_detect_files_to_archive(root_dir: Path | None = None) -> list[dict[str, str]]:
    """
    Automatically detect files that should be archived based on version patterns.

    Args:
        root_dir: Root directory of the memory bank

    Returns:
        List of operations for detected files
    """
    if root_dir is None:
        root_dir = memory_bank_root

    operations = []

    for memory_type in MEMORY_TYPES:
        active_dir = root_dir / memory_type / "active"
        archive_dir = root_dir / memory_type / "archive"

        if not active_dir.exists():
            continue

        # Group files by base name
        file_groups = {}
        for file_path in active_dir.glob("*.md"):
            base_name = file_path.stem
            if "_v" in base_name:
                base_name = base_name.split("_v")[0]

            if base_name not in file_groups:
                file_groups[base_name] = []
            file_groups[base_name].append(file_path)

        # For each group with multiple versions, keep newest and archive others
        for base_name, files in file_groups.items():
            if len(files) <= 1:
                continue

            # Sort by version, newest first
            files.sort(key=lambda p: p.stat().st_mtime, reverse=True)

            # Keep the newest file, archive others
            for file_to_archive in files[1:]:
                operations.append(
                    {
                        "operation_type": "move",
                        "source": str(file_to_archive.relative_to(root_dir)),
                        "destination_folder": str(archive_dir.relative_to(root_dir)),
                        "description": f"Archive older version of {base_name}",
                        "memory_type": memory_type,
                    }
                )

    return operations


def generate_operation_report(
    operations: list[dict[str, Any]],
    successful_ops: list[dict[str, Any]] | None = None,
    failed_ops: list[dict[str, Any]] | None = None,
    output_file: Path | None = None,
) -> str:
    """
    Generate a markdown report of all operations.

    Args:
        operations: List of all operations
        successful_ops: List of successful operations (if None, reports as planned)
        failed_ops: List of failed operations (if None, not included)
        output_file: Path to write the report to (if None, not written to file)

    Returns:
        Report as a string
    """
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    if successful_ops is None and failed_ops is None:
        status = "📋 Planned"
    elif failed_ops and len(failed_ops) > 0:
        status = "⚠️ Partially Completed"
    else:
        status = "✅ Completed"

    # Create report header
    report = f"""# Memory Bank Operations Report

**Generated:** {timestamp}
**Status:** {status}

## Summary

"""

    # Add summary statistics
    total_ops = len(operations)
    successful_count = len(successful_ops) if successful_ops is not None else 0
    failed_count = len(failed_ops) if failed_ops is not None else 0

    if successful_ops is None and failed_ops is None:
        report += f"- **Planned Operations:** {total_ops}\n"
    else:
        report += f"- **Total Operations:** {total_ops}\n"
        report += f"- **Successful Operations:** {successful_count}\n"
        if failed_count > 0:
            report += f"- **Failed Operations:** {failed_count}\n"

    # Group operations by memory type
    memory_type_groups: dict[str, list[dict[str, Any]]] = {}
    for op in operations:
        memory_type = op.get("memory_type", "unknown")
        if memory_type not in memory_type_groups:
            memory_type_groups[memory_type] = []
        memory_type_groups[memory_type].append(op)

    # Add operation details by memory type
    report += "\n## Operations by Memory Type\n\n"

    for memory_type, ops in memory_type_groups.items():
        report += f"### {memory_type.capitalize()} Memory\n\n"

        if len(ops) == 0:
            report += "No operations planned or executed.\n\n"
            continue

        report += "| Source | Destination | Status | Description |\n"
        report += "|--------|-------------|--------|-------------|\n"

        for op in ops:
            source = op.get("source", "N/A")
            dest = op.get("destination", "N/A")
            if dest == "N/A" and "destination_folder" in op:
                dest = op.get("destination_folder", "N/A")

            desc = op.get("description", "")

            # Determine status
            if successful_ops is None and failed_ops is None:
                status = "Planned"
            elif successful_ops and any(
                s.get("source") == source for s in successful_ops
            ):
                status = "✅ Success"
            elif failed_ops and any(f.get("source") == source for f in failed_ops):
                status = "❌ Failed"
            else:
                status = "❓ Unknown"

            report += f"| {source} | {dest} | {status} | {desc} |\n"

        report += "\n"

    # Add failure details if any
    if failed_ops and len(failed_ops) > 0:
        report += "## Failed Operations Details\n\n"

        for i, op in enumerate(failed_ops):
            source = op.get("source", "N/A")
            reason = op.get("reason", "Unknown reason")

            report += f"### Failure {i + 1}: {source}\n\n"
            report += f"**Reason:** {reason}\n\n"

    # Write report to file if requested
    if output_file:
        safe_file_operation(
            _write_report_to_file,
            output_file,
            "Error writing report to file",
            output_file,
            report,
        )

    return report


def _write_report_to_file(output_file: Path, report: str) -> bool:
    """Internal function to write a report to a file."""
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(report)
    logger.info(f"Operation report written to {output_file}")
    print_success(f"Operation report written to {output_file}")
    return True


if __name__ == "__main__":
    main()
