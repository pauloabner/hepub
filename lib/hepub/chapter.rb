module Hepub
  # Chapter
  class Chapter
    attr_reader :title, :author, :sections
    def initialize(title, author)
      @sections = []
      @title = title
      @author = author
    end

    def add_section(title, content)
      section = {}
      section[:title] = title
      section[:content] = content
      @sections.push(section)
    end

    def count_sections
      @sections.count
    end
  end
end
