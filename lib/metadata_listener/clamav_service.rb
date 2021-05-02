# frozen_string_literal: true

require 'clamby'

module MetadataListener
  class ClamavService
    # @param [String] path of file to scan
    # @note This duplicates Clamby::Command with some changes so that instances where the executeable returns nil or 2
    # do not result in false positives.
    def self.call(path)
      return false unless Pathname.new(path).exist?

      Clamby::Command.new.run 'clamscan', path, '--no-summary'

      # $CHILD_STATUS maybe nil if the execution itself (not the client process) fails
      case $CHILD_STATUS&.exitstatus
      when 0
        false
      when 1
        true
      else
        raise Clamby::ClamscanClientError.new('Clamscan client error')
      end
    end
  end
end
