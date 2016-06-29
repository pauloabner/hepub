module Hepub
  class TitlePage
    attr_reader :metadata, :template_file

    def initialize(metadata:, template_file:)
      @metadata = metadata
      @template_file = template_file
    end

    def to_s
      template = Util.file_to_str template_file
      tags.each do |tag|
        template.gsub!("{{ #{tag} }}", metadata.value_of(tag) )
      end
      template
    end

    def tags
      Util.tags_from_file(template_file)
    end
  end
end
