# frozen_string_literal: true
require 'nokogiri'

module Hepub
  # Onix
  class Onix
    TITLE_PATH = 'ONIXMessage Product Title TitleText'
    AUTHORS_PATH = 'ONIXMessage Product Contributor PersonName'
    COVER_PATH = 'ONIXMessage Product CoverImageLink'

    def initialize(onix_file)
      @xml = Hepub::Util.file_to_str onix_file
    end

    def to_s
      @xml
    end

    def check?
      xml_doc = Nokogiri::XML(to_s)
      !(xml_doc.css(TITLE_PATH).empty? &&
        xml_doc.css(AUTHORS_PATH).empty? &&
        xml_doc.css(COVER_PATH).empty?)
    end

    def metadata
      metadata = Hepub::Metadata.new
      return metadata unless check?
      xml_doc = Nokogiri::XML(to_s)

      metadata.change_value('TITLE', xml_doc.css(TITLE_PATH).first.text)
      metadata.change_value('AUTHOR', xml_doc.css(AUTHORS_PATH).first.text)
      metadata
    end
  end
end
