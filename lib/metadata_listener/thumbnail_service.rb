# frozen_string_literal: true

require 'http'
require 'nokogiri'
require 'image_processing/mini_magick'

module MetadataListener
  class ThumbnailService
    class ThumbnailError < StandardError; end
    # @param [String] path of file to compute digest
    def self.call(path)
      raise ThumbnailError, 'file not found' unless Pathname.new(path).exist?

      begin
        MetadataListener.logger.info("Processing file #{path}")
        thumbnail = ImageProcessing::MiniMagick.loader(page: 0)
          .convert('png')
          .resize_to_limit(400,400)
          .call(path)
        MetadataListener::s3_client.put_object("thumbnails/400,400/#{File.basename(path).split(".")[0]}.png", thumbnail)
        # File only gets cleaned up when the ruby process ends. 
        FileUtils.rm(thumbnail.path)
      rescue
        MetadataListener.logger.warn("Failed to create Thumbnail for #{path}")
      end
    
    end
  end
end