#!/bin/bash

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "Error: uv is not installed or not in PATH"
    exit 1
fi

echo "uv found: $(which uv)"
echo "Starting sync of all project environments..."
echo ""

# Get the root directory (two levels up from this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Root directory: $ROOT_DIR"
echo ""

# Track success/failure
SUCCESS_COUNT=0
FAILURE_COUNT=0
FAILED_DIRS=()

# Iterate through all directories in the root
for dir in "$ROOT_DIR"/*/ ; do
    # Get just the directory name
    dir_name=$(basename "$dir")
    
    # Check if pyproject.toml exists (indicating it's a uv project)
    if [ -f "$dir/pyproject.toml" ]; then
        echo "========================================"
        echo "Processing: $dir_name"
        echo "========================================"
        
        cd "$dir" || { echo "Failed to cd into $dir"; FAILURE_COUNT=$((FAILURE_COUNT + 1)); FAILED_DIRS+=("$dir_name"); continue; }
        
        # Run uv lock
        echo "Running: uv lock"
        if uv lock; then
            echo "✓ uv lock succeeded"
        else
            echo "✗ uv lock failed"
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            FAILED_DIRS+=("$dir_name")
            echo ""
            continue
        fi
        
        # Run uv sync
        echo "Running: uv sync"
        if uv sync; then
            echo "✓ uv sync succeeded"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        else
            echo "✗ uv sync failed"
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            FAILED_DIRS+=("$dir_name")
        fi
        
        echo ""
    else
        echo "Skipping $dir_name (no pyproject.toml found)"
        echo ""
    fi
done

# Return to root directory
cd "$ROOT_DIR"

# Print summary
echo "========================================"
echo "Summary"
echo "========================================"
echo "Successfully synced: $SUCCESS_COUNT project(s)"
echo "Failed: $FAILURE_COUNT project(s)"

if [ ${#FAILED_DIRS[@]} -gt 0 ]; then
    echo "Failed directories:"
    for failed_dir in "${FAILED_DIRS[@]}"; do
        echo "  - $failed_dir"
    done
    exit 1
fi

echo ""
echo "All projects synced successfully! ✓"

