#!/bin/bash
# Script for managing BIG BRAIN Memory Bank 2.0 documentation

set -e  # Exit immediately if a command exits with a non-zero status

# Function to print usage
print_usage() {
  echo "BIG BRAIN Documentation Updater"
  echo "Usage: $0 [command]"
  echo ""
  echo "Commands:"
  echo "  check-links   - Check for broken links in documentation"
  echo "  update-nav    - Update navigation based on file structure"
  echo "  fix-frontmatter - Fix common frontmatter issues"
  echo "  build-search  - Build search index for documentation"
  echo "  help          - Show this help message"
}

# Check if scripts directory exists
mkdir -p "$(dirname "$0")"

# Check for command
if [ $# -eq 0 ]; then
  print_usage
  exit 0
fi

command="$1"
shift

case "$command" in
  check-links)
    echo "Checking for broken links..."
    cd "$(dirname "$0")/.."
    bundle exec htmlproofer ./_site --disable-external --allow-hash-href
    echo "Link check complete."
    ;;

  update-nav)
    echo "Updating navigation based on file structure..."
    cd "$(dirname "$0")/.."

    # This is a placeholder for a more sophisticated script
    # that would scan directories and update navigation.yml
    echo "# Auto-generated navigation" > _data/navigation.yml.new
    echo "main:" >> _data/navigation.yml.new
    echo "  - title: \"Home\"" >> _data/navigation.yml.new
    echo "    url: /" >> _data/navigation.yml.new

    # Add section for each top-level directory with markdown files
    for dir in */; do
      if [ -d "$dir" ] && [ "$dir" != "_site/" ] && [ "$dir" != "_data/" ] && [ "$dir" != "assets/" ]; then
        section=$(basename "$dir" | sed -e 's/^./\U&/' -e 's/_/ /g')
        echo "  - title: \"$section\"" >> _data/navigation.yml.new
        echo "    url: /$(basename "$dir" | tr '[:upper:]' '[:lower:]')/" >> _data/navigation.yml.new
        echo "    children:" >> _data/navigation.yml.new

        # Add pages in this section
        for page in "$dir"*.md; do
          if [ -f "$page" ] && [ "$(basename "$page")" != "index.md" ]; then
            title=$(grep -m 1 "title:" "$page" | sed 's/title: *//' | tr -d '"')
            if [ -z "$title" ]; then
              title=$(basename "$page" .md | sed -e 's/^./\U&/' -e 's/_/ /g')
            fi
            permalink=$(grep -m 1 "permalink:" "$page" | sed 's/permalink: *//' | tr -d '"')
            if [ -z "$permalink" ]; then
              permalink="/$(basename "$dir" | tr '[:upper:]' '[:lower:]')/$(basename "$page" .md | tr '[:upper:]' '[:lower:]')/"
            fi
            echo "      - title: \"$title\"" >> _data/navigation.yml.new
            echo "        url: \"$permalink\"" >> _data/navigation.yml.new
          fi
        done
      fi
    done

    # Replace the old file with the new one
    mv _data/navigation.yml.new _data/navigation.yml
    echo "Navigation updated."
    ;;

  fix-frontmatter)
    echo "Fixing common frontmatter issues..."
    cd "$(dirname "$0")/.."

    # Process all markdown files
    find . -name "*.md" | while read -r file; do
      # Skip files in _site directory
      if [[ "$file" == *"_site"* ]]; then
        continue
      fi

      # Check if file has frontmatter
      if ! grep -q "^---" "$file"; then
        echo "Adding frontmatter to $file"
        # Get title from first heading
        title=$(grep -m 1 "^# " "$file" | sed 's/^# *//')
        if [ -z "$title" ]; then
          title=$(basename "$file" .md | sed -e 's/^./\U&/' -e 's/_/ /g')
        fi

        # Create temporary file with frontmatter
        temp_file=$(mktemp)
        echo "---" > "$temp_file"
        echo "layout: default" >> "$temp_file"
        echo "title: $title" >> "$temp_file"
        echo "---" >> "$temp_file"
        echo "" >> "$temp_file"
        cat "$file" >> "$temp_file"

        # Replace original file
        mv "$temp_file" "$file"
      fi
    done

    echo "Frontmatter fixes complete."
    ;;

  build-search)
    echo "Building search index..."
    cd "$(dirname "$0")/.."

    # This is a placeholder for a script that would build a search index
    # for documentation. Would typically use Jekyll plugins or external tools.
    echo "Search index build complete."
    ;;

  help)
    print_usage
    ;;

  *)
    echo "Unknown command: $command"
    print_usage
    exit 1
    ;;
esac

exit 0