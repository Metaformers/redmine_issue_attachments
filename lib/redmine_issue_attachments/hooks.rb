module RedmineIssueAttachments
  class Hooks < Redmine::Hook::ViewListener
    # Hook into the project overview sidebar
    render_on :view_projects_show_sidebar_bottom,
              partial: 'projects/download_attachments_button'

    # Hook into the issue details page
    render_on :view_issues_show_details_bottom,
              partial: 'issues/download_attachments_button'
  end
end
