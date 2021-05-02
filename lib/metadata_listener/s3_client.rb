# frozen_string_literal: true

require 'aws-sdk-s3'

module MetadataListener
  class S3Client
    def initialize
      raise ArgumentError, 'S3 configuration is missing required options' unless valid?

      Aws.config.update(s3_options)
    end

    # @param [String] key
    # @return [Seahorse::Client::Response]
    def download_file(key)
      client.get_object(bucket: bucket, key: key, response_target: Tempfile.new)
    end

    # @param [String] key
    # @param [File] file
    def put_object(key, file)
      if object_exists?(bucket, key)
        MetadataListener.logger.warn('File exists, not overwriting')
      else
        client.put_object(
          bucket: bucket,
          key: key,
          body: IO.read(file)
        )
      end
    end

    private

      def object_exists?(bucket, path)
        client.head_object(bucket: bucket, key: path)
        true
      rescue StandardError
        false
      end

      def valid?
        bucket.present? && s3_options.none? { |_key, value| value.nil? }
      end

      def client
        @client ||= Aws::S3::Client.new
      end

      def bucket
        @bucket ||= ENV['AWS_BUCKET']
      end

      def s3_options
        @s3_options ||= if ENV.key?('S3_ENDPOINT')
                          base_options.merge(endpoint: ENV['S3_ENDPOINT'], force_path_style: true)
                        else
                          base_options
                        end
      end

      def base_options
        {
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
          region: ENV.fetch('AWS_REGION', 'us-east-1')
        }
      end
  end
end
