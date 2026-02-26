# Redmine Issue Attachments

A Redmine plugin that adds "Download All Attachments" buttons to download attachments as zip files from issues and projects.

## Features

- **Issue Downloads**: Adds a "Download Attachments" button to issue pages to download all attachments for that issue as a zip file
- **Project Downloads**: Adds a "Download All Attachments" link in the project sidebar to download all attachments from all issues in the project, organized by issue folders
- **S3 Support**: Compatible with S3 storage plugins like [redmica_s3](https://github.com/redmica/redmica_s3)
- Button only appears when attachments exist

## Requirements

- Redmine 4.2.0 or higher
- `rubyzip` gem (included with Redmine)

## Installation

1. Navigate to the Redmine plugins directory:
   ```bash
   cd /path/to/redmine/plugins
   ```

2. Clone the plugin repository:
   ```bash
   git clone https://github.com/vaibhavpetkar/redmine_issue_attachments.git
   ```

3. Install dependencies:
   ```bash
   bundle install
   ```

4. Run migrations:
   ```bash
   bundle exec rake redmine:plugins:migrate NAME=redmine_issue_attachments RAILS_ENV=production
   ```

5. Clear cache and restart Redmine:
   ```bash
   bundle exec rake tmp:cache:clear
   sudo systemctl restart redmine
   ```

## Permissions

The plugin adds a **Download project attachments** permission under the Issue Tracking module. Enable this permission for roles that should be able to download all attachments from a project.

## Changelog

### 0.0.2
- Added project-level attachment downloads
- Added S3 storage support (redmica_s3 compatibility)
- Attachments organized in `issue_<id>/` folders within zip files

### 0.0.1 (2024-07-22)
- Initial release
- Issue-level attachment downloads
- Compatible with Redmine 4.2.x and higher
