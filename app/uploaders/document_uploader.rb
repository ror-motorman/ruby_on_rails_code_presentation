class DocumentUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "documents/#{model.id}_#{model.full_name}"
  end

  def extension_white_list
    %w(doc docx pdf txt)
  end
end
