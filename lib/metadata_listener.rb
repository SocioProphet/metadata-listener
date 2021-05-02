# frozen_string_literal: true

module MetadataListener
  require 'metadata_listener/redis'
  require 'metadata_listener/job'
  require 'metadata_listener/s3_client'
  require 'metadata_listener/fits_service'
  require 'metadata_listener/tika'
  require 'metadata_listener/clamav_service'
  require 'metadata_listener/virus_reporting_service'
  require 'metadata_listener/metadata_reporting_service'
  require 'metadata_listener/digest_service'
  require 'metadata_listener/digest_reporting_service'
  require 'metadata_listener/thumbnail_service'

  class << self
    # @note Because this is intended to run inside a Docker container, it is customary to write logs to STDOUT
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def s3_client
      @s3_client ||= S3Client.new
    end
  end
end
