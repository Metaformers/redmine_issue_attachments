class ProjectAttachmentsController < ApplicationController
  before_action :find_project
  before_action :authorize

  def download
    # Get all attachments from issues in this project
    attachments = Attachment.joins("INNER JOIN issues ON issues.id = attachments.container_id AND attachments.container_type = 'Issue'")
                            .where(issues: { project_id: @project.id })

    if attachments.any?
      # Create a zip file of all attachments, organized by issue
      zip_file = Tempfile.new(["project_attachments", ".zip"], binmode: true)
      Zip::File.open(zip_file.path, Zip::File::CREATE) do |zip|
        attachments.each do |attachment|
          issue = attachment.container
          # Organize by issue folder to avoid filename collisions
          folder_name = "issue_#{issue.id}"
          entry_name = "#{folder_name}/#{attachment.filename}"

          # Handle duplicate filenames within the same issue
          counter = 1
          original_entry_name = entry_name
          while zip.find_entry(entry_name)
            extension = File.extname(attachment.filename)
            basename = File.basename(attachment.filename, extension)
            entry_name = "#{folder_name}/#{basename}_#{counter}#{extension}"
            counter += 1
          end

          next unless attachment.readable?
          zip.get_output_stream(entry_name) do |out|
            if File.exist?(attachment.diskfile)
              # Local storage
              out.write(File.binread(attachment.diskfile))
            elsif attachment.respond_to?(:object)
              # redmica_s3 plugin - read from S3 via 'object' method
              out.write(attachment.object.get.body.read)
            elsif defined?(RedmicaS3::Connection)
              # redmica_s3 - use connection to get object
              s3_key = File.join(attachment.disk_directory.to_s, attachment.disk_filename)
              obj = RedmicaS3::Connection.object(s3_key)
              out.write(obj.get.body.read)
            end
          end
        end
      end

      # Send the zip file to the browser
      send_file zip_file.path,
                filename: "#{@project.identifier}_attachments.zip",
                type: "application/zip",
                disposition: 'attachment'
    else
      redirect_to project_path(@project), alert: 'No attachments available to download.'
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end