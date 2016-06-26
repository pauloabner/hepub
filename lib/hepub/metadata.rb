module Hepub
  class Metadata
    # title_page
    attr_accessor :title, :subtitle, :author, :reference
    # cover_page
    attr_accessor :cover_path

    def initialize(options = {})
      self.title = options[:title]
      self.subtitle = options[:subtitle]
      self.author = options[:author]
      self.reference = options[:reference]
      self.cover_path = options[:cover_path]
      create_array
    end

    def value_of(key)
      @array[key] ||= "{{ #{key} }}"
    end

    private

    def create_array
      @array = {
        'TITLE' => self.title ||= '{{ TITLE }}',
        'SUBTITLE' => self.subtitle ||= '{{ SUBTITLE }}',
        'AUTHOR' => self.author ||= '{{ AUTHOR }}',
        'REFERENCE' => self.reference ||= '{{ REFERENCE }}',
        'COVER_PATH' => self.cover_path ||= '{{ COVER_PATH }}'
      }
    end
  end
end
