class Attachment < ActiveRecord::Base

  def uploaded_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  named_scope :from_client, {
    :select     => "id, filename, content_type, description",
    :conditions => "table_rel = 'Client' "
  }

  named_scope :from_provider, {
    :select     => "id, filename, content_type, description",
    :conditions => "table_rel = 'Provider' "
  }

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end

end

