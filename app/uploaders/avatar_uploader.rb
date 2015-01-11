# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #File.join(Rails.root, 'uploads', model.class.to_s.underscore, mounted_as.to_s, model.id.to_s)
  end

  version :thumb do
     process :resize_to_fit => [100, 100]
  end

  version :show_circle do
    process :convert => 'png'

    process :resize_to_fit => [200, 200]
    #process :gravity => 'center'
    #process :crop => [250, 250, 0, 0]
    process :resize_and_pad => [220, 220]
    process :circle_vingette => [300]
    process :resize_to_fit => [200, 200]
  end

  version :show_square do
    process :resize_to_fit => [250, 250]
  end


  def circle_vingette(diameter)
    manipulate! do |img|
      #img.forma('png') do |png|
      #  img.resize "#{diameter}x#{diameter}^"
      #  img.gravity 'center'
      #  img.crop "#{diameter}x#{diameter}+0+0"
      #  img.alpha 'set'
      #  img.background 'none'
        img.vignette '0X1'
      #end
     img
    end
  end

  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

#c:\Users\jf\Desktop>convert shawn.jpg -resize "250x250^" -gravity center -crop "250x250+0+0" -alpha set -background none -vignette 0x2 test.png
end
