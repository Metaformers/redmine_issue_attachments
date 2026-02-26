Rails.application.routes.draw do
    match 'issues/:id/download_attachments' => 'issue_attachments#download', via: :get, as: :download_attachments_issue
    match 'projects/:id/download_attachments' => 'project_attachments#download', via: :get, as: :download_attachments_project
  end
  