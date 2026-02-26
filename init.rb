require_relative 'lib/redmine_issue_attachments/hooks'
require_relative 'app/helpers/issue_attachments_helper'

Rails.configuration.to_prepare do
  ApplicationHelper.include IssueAttachmentsHelper
end

Redmine::Plugin.register :redmine_issue_attachments do
  name 'Redmine Issue Attachments Plugin'
  author 'Vaibhav Petkar'
  description 'This plugin adds buttons to download all attachments for an issue or all issues within a project.'
  version '0.0.2'
  url 'https://github.com/vaibhavpetkar/redmine_issue_attachments'
  author_url 'https://github.com/vaibhavpetkar'

  # Ensure plugin is compatible with Redmine version
  requires_redmine version_or_higher: '4.2.0'

  # Register permission for downloading project attachments
  project_module :issue_tracking do
    permission :download_project_attachments, { project_attachments: [:download] }
  end
end
