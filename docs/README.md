# BIG BRAIN Memory Bank 2.0 Documentation Site

This directory contains the documentation for the BIG BRAIN Memory Bank 2.0
system, configured for GitHub Pages.

## GitHub Pages Configuration

This documentation site uses GitHub Pages with Jekyll to provide a clean,
structured documentation experience. The site uses the Cayman theme with custom
styling.

### Key Configuration Files

- `_config.yml` - Main Jekyll configuration
- `_data/navigation.yml` - Site navigation structure
- `assets/css/style.scss` - Custom styling

## Local Development

To test this documentation site locally:

1. Install Ruby and Jekyll following the
   [Jekyll installation instructions](https://jekyllrb.com/docs/installation/)

2. Install the dependencies:

   ```
   cd docs
   bundle install
   ```

3. Start the local Jekyll server:

   ```
   bundle exec jekyll serve
   ```

4. Access the site at http://localhost:4000

## Documentation Structure

The documentation follows this structure:

- `index.md` - Main landing page
- `Guides/` - User guides and tutorials
- `Architecture/` - System architecture information
- `Reference/` - Technical reference materials
- `assets/` - Images, CSS, and other assets

## Adding New Content

When adding new content:

1. Create your Markdown files in the appropriate directory
2. Add front matter at the top of each file:
   ```
   ---
   layout: default
   title: Your Page Title
   parent: Section Name (if applicable)
   nav_order: X (position in navigation)
   permalink: /your-page-url/
   ---
   ```
3. Update `_data/navigation.yml` if adding a top-level section

## GitHub Pages Publishing

This documentation is automatically published to GitHub Pages when changes are
committed to the main branch. The publishing process:

1. GitHub detects changes to the docs/ directory
2. Jekyll builds the site using the configuration in `_config.yml`
3. The built site is published to the GitHub Pages URL

## Troubleshooting

If you encounter issues with the documentation site:

1. Check the GitHub Pages build logs in the repository settings
2. Validate your Markdown and front matter syntax
3. Ensure all links are relative to the site root
4. Test locally before pushing changes

## Contact

For questions about this documentation site, please contact the BIG BRAIN Memory
Bank team.
