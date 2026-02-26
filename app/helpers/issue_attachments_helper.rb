module IssueAttachmentsHelper
    def download_attachments_button(issue)
      return unless issue.attachments.any?

      link_to 'Download All Attachments', download_attachments_issue_path(issue),
              class: 'button', title: 'Download all attachments for this issue'
    end

    def download_project_attachments_button(project)
      return unless project_has_attachments?(project)

      link_to 'Download All Attachments', download_attachments_project_path(project),
              class: 'icon icon-download', title: 'Download all attachments from all issues in this project'
    end

    def project_has_attachments?(project)
      Attachment.joins("INNER JOIN issues ON issues.id = attachments.container_id AND attachments.container_type = 'Issue'")
                .where(issues: { project_id: project.id })
                .exists?
    end
  end
