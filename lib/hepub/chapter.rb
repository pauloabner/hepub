module Hepub
  class Chapter
    attr_reader :title, :author, :sections
    def initialize(title, author)
      @sections = []
      @title = title
      @author = author
    end

    def add_section(title, content)
      chapter = Hash.new
      chapter[:title] = title
      chapter[:content] = content
      @sections.push(chapter)
    end

    def count_sections
      @sections.count
    end
  end
end
