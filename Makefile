# Makefile for BIG BRAIN Memory Bank 2.0 Documentation

# Configuration variables
DOCS_DIR = docs
JEKYLL_ENV = JEKYLL_ENV=production
BUNDLE = bundle
JEKYLL = $(BUNDLE) exec jekyll

# Default goal
.PHONY: all
all: help

# Help message
.PHONY: help
help:
	@echo "BIG BRAIN Memory Bank 2.0 Documentation Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  setup       - Install required dependencies for documentation site"
	@echo "  serve       - Run a local development server"
	@echo "  build       - Build the documentation site for production"
	@echo "  clean       - Remove build artifacts"
	@echo "  validate    - Check for broken links and HTML issues"
	@echo "  update-deps - Update Ruby dependencies"
	@echo "  new-page    - Create a new documentation page (args: NAME=page_name SECTION=section_name)"
	@echo "  gh-pages    - Prepare documentation for GitHub Pages"
	@echo ""
	@echo "Example usage:"
	@echo "  make serve      - Start local development server"
	@echo "  make new-page NAME=installation SECTION=guides - Create a new page in guides section"
	@echo "  make gh-pages   - Prepare for GitHub Pages deployment"

# Setup the documentation environment
.PHONY: setup
setup:
	@echo "Setting up documentation dependencies..."
	cd $(DOCS_DIR) && $(BUNDLE) install
	@echo "Setup complete. You can now run 'make serve' to start the local server."

# Serve the documentation locally
.PHONY: serve
serve:
	@echo "Starting local server at http://localhost:4000"
	cd $(DOCS_DIR) && $(JEKYLL) serve

# Build the documentation site
.PHONY: build
build:
	@echo "Building documentation site..."
	cd $(DOCS_DIR) && $(JEKYLL_ENV) $(JEKYLL) build
	@echo "Build complete. Output is in $(DOCS_DIR)/_site."

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	cd $(DOCS_DIR) && $(JEKYLL) clean
	@echo "Cleanup complete."

# Validate documentation
.PHONY: validate
validate:
	@echo "Validating documentation links and HTML..."
	@if ! command -v htmlproofer >/dev/null 2>&1; then \
		echo "htmlproofer not found. Installing..."; \
		gem install html-proofer; \
	fi
	cd $(DOCS_DIR) && $(JEKYLL_ENV) $(JEKYLL) build --strict_front_matter
	cd $(DOCS_DIR) && htmlproofer ./_site --disable-external --allow-hash-href
	@echo "Validation complete."

# Update dependencies
.PHONY: update-deps
update-deps:
	@echo "Updating Ruby dependencies..."
	cd $(DOCS_DIR) && $(BUNDLE) update
	@echo "Dependencies updated."

# Create a new documentation page
.PHONY: new-page
new-page:
	@if [ -z "$(NAME)" ]; then \
		echo "Error: NAME parameter is required. Example: make new-page NAME=installation SECTION=guides"; \
		exit 1; \
	fi
	@if [ -z "$(SECTION)" ]; then \
		echo "Error: SECTION parameter is required. Example: make new-page NAME=installation SECTION=guides"; \
		exit 1; \
	fi
	@echo "Creating new page: $(NAME) in section: $(SECTION)"
	@mkdir -p $(DOCS_DIR)/$(SECTION)
	@touch $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "---" > $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "layout: default" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "title: $(shell echo '$(NAME)' | sed -e 's/^./\U&/' -e 's/_/ /g' -e 's/\b\(.\)/\U\1/g')" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "parent: $(shell echo '$(SECTION)' | sed -e 's/^./\U&/' -e 's/_/ /g' -e 's/\b\(.\)/\U\1/g')" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "nav_order: 1" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "permalink: /$(SECTION)/$(NAME)/" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "---" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "# $(shell echo '$(NAME)' | sed -e 's/^./\U&/' -e 's/_/ /g' -e 's/\b\(.\)/\U\1/g')" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "" >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "Content for $(NAME) goes here." >> $(DOCS_DIR)/$(SECTION)/$(NAME).md
	@echo "Page created at $(DOCS_DIR)/$(SECTION)/$(NAME).md"

# GitHub Pages specific commands
.PHONY: gh-pages
gh-pages: build
	@echo "Preparing documentation for GitHub Pages..."
	# Ensure all paths are correct for GitHub Pages
	@echo "Checking frontmatter in markdown files..."
	cd $(DOCS_DIR) && ./scripts/update_docs.sh fix-frontmatter || cd $(DOCS_DIR) && ./scripts/update_docs.bat fix-frontmatter

	# Create necessary GitHub Pages files
	@echo "Checking for CNAME file..."
	@if [ ! -f "$(DOCS_DIR)/CNAME" ]; then \
		echo "Creating a placeholder CNAME file (update this with your actual domain if needed)"; \
		echo "# Replace with your custom domain if using one" > $(DOCS_DIR)/CNAME; \
	fi

	@echo "Checking for Gemfile.lock..."
	@if [ ! -f "$(DOCS_DIR)/Gemfile.lock" ]; then \
		echo "Running bundle install to generate Gemfile.lock"; \
		cd $(DOCS_DIR) && $(BUNDLE) install; \
	fi

	@echo "GitHub Pages preparation complete."
	@echo "To deploy to GitHub Pages:"
	@echo "1. Commit all changes to your repository"
	@echo "2. Push to the main branch"
	@echo "3. Go to your repository settings and enable GitHub Pages for the docs/ folder"

# Deploy target (placeholder - implement based on your deployment strategy)
.PHONY: deploy
deploy:
	@echo "Deploying documentation site..."
	@echo "NOTE: This is a placeholder. Implement based on your deployment strategy."
	@echo "For GitHub Pages, typically you just need to push changes to the repository."
