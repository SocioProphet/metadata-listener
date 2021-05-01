# frozen_string_literal: true

require 'http'
require 'nokogiri'

module MetadataListener
  class DigestService
    class DigestError < StandardError; end
    # @param [String] path of file to compute digest
    def self.call(path)
      raise DigestError, 'file not found' unless Pathname.new(path).exist?

      sha = Digest::SHA2.new
      File.open(path) do |f|
        while chunk = f.read(256)
          sha << chunk
        end
      end
      sha.hexdigest
    end
  end
end
