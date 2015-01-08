# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  #include CarrierWave::Processing::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #File.join(Rails.root, 'uploads', model.class.to_s.underscore, mounted_as.to_s, model.id.to_s)
  end

  version :thumb do
     process :resize_to_fit => [100, 100]
  end

  version :show do
    #process :resize_to_fit => [250, 250]
    process :circle_vingette => [250]

  end

  def circle_vingette(diameter)
    manipulate! do |img|
      img.format 'png'
      img.resize_to_fit(250, 250)
      img.gravity 'center'
      img.crop "#{250}x#{250}+0+0"
      img.alpha 'set'
      img.background 'none'
      img.vignette '0x2'
    end
  end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

#c:\Users\jf\Desktop>convert shawn.jpg -resize "250x250^" -gravity center -crop "250x250+0+0" -alpha set -background none -vignette 0x2 test.png
end
