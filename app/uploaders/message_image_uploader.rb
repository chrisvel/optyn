# encoding: utf-8

class MessageImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Height is kept high below so that users can put tall images such as infographics
  # in their emails.
  # process :resize_to_fit => [580, 0] , :if => :check_dimensions?

  # process :store_geometry

  # process :resize_per_image

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  #storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #'uploads/shop'
  end



  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_geometry
    if @file
      img = ::Magick::Image::read(@file.file).first
      if model
        model.width = img.columns
        model.height = img.rows
      end
    end
  end

  def rearrange_dimensions()
    if check_dimensions?(@file)
      if model.image_width.present? || model.image_width.to_i > 0
        resize_to_fit(model.image_width, 0) 
      else
        resize_to_fit(580, 0)
      end
    end
  end

  def check_dimensions?(file)
    img = ::Magick::Image::read(@file.file).first
    width = img.columns
    height = img.rows
    width.to_i > model.image_width.to_i
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
