# frozen_string_literal: true
module Hepub
  # ChapterPage
  class ChapterPage

    def initialize(metadata, template_file, chapter)
      @metadata = metadata
      @template_file = template_file
      @chapter = chapter
      add_chapter_to_metadata chapter
    end

    def to_s
      template = Util.file_to_str @template_file
      tags.each do |tag|
        template.gsub!("{{ #{tag} }}", @metadata.value_of(tag))
      end
      template = template_with_section template unless @chapter.sections.empty?
      template
    end

    private

    def tags
      Util.tags_from_file(@template_file)
    end

    def add_chapter_to_metadata(chapter)
      @metadata.change_value('CHAPTER_TITLE', chapter.title)
      @metadata.change_value('CHAPTER_AUTHOR', chapter.author)
    end

    def template_with_section(template)
      sections_tags = Util.tags_from_file "#{@template_file}_section"

      template.gsub!('{{ SECTION }}', sections(sections_tags))
    end

    def add_section_to_metadata(section)
      @metadata.change_value('SECTION_TITLE', section[:title])
      @metadata.change_value('SECTION_CONTENT', section[:content])
    end

    def sections(tags)
      sections = ''
      @chapter.sections.each do |s|
        section_template = Util.file_to_str "#{@template_file}_section"
        add_section_to_metadata s
        tags.each do |tag|
          section_template.gsub!("{{ #{tag} }}", @metadata.value_of(tag))
        end
        sections += section_template
      end
      sections
    end
  end
end
