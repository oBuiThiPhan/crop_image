class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process :crop_image

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  version :medium do
    process resize_to_fit: [300, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "no.jpg"].compact.join('_'))
  end

  def crop_image
    if model.avatar_crop_x.present?
      manipulate! do |img|
        x = model.avatar_crop_x.to_i
        y = model.avatar_crop_y.to_i
        w = model.avatar_crop_w.to_i
        h = model.avatar_crop_h.to_i
        img.crop "#{w}x#{h}+#{x}+#{y}"
      end
    end
  end
end
