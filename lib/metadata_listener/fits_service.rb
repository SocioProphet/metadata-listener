# frozen_string_literal: true

require 'http'
require 'open3'

module MetadataListener
  class FitsError < StandardError; end

  class FitsService
    # @param [String] path of file to scan
    # @return [Hash] converted from the xml output
    def self.call(path)
      return {} unless Pathname.new(path).exist?

      stdout, stderr, status = Open3.capture3("#{ENV.fetch('FITS_PATH', '/usr/share/fits/fits.sh')} -i #{path}")
      raise FitsError, stderr unless status.success?

      Hash.from_xml(stdout.to_s)
    end
  end
end
