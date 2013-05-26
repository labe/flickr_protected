class PhotoUploader < CarrierWave::Uploader::Base
  storage :file
  include CarrierWave::MiniMagick

  def store_dir
    "photos"
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [800, 800]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
end
