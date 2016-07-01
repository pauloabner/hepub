# frozen_string_literal: true
# Hepub
module Hepub
  # Metadata
  class Metadata
    # title_page
    attr_accessor :title, :subtitle, :author, :reference
    # cover_page
    attr_accessor :cover_path
    # chapter_page
    attr_accessor :chapter_title, :chapter_author

    def initialize(options = {})
      setup(options)
    end

    def value_of(key)
      @array[key] ||= "{{ #{key} }}"
    end

    def change_value(key, value)
      @array[key] = value
    end

    def add_options(options)
      setup(options)
    end

    private

    def create_array
      @array = {
        'TITLE' => self.title ||= '{{ TITLE }}',
        'SUBTITLE' => self.subtitle ||= '{{ SUBTITLE }}',
        'AUTHOR' => self.author ||= '{{ AUTHOR }}',
        'REFERENCE' => self.reference ||= '{{ REFERENCE }}',
        'COVER_PATH' => self.cover_path ||= '{{ COVER_PATH }}',
        'CHAPTER_TITLE' => self.chapter_title ||= '{{ CHAPTER_TITLE }}',
        'CHAPTER_AUTHOR' => self.chapter_author ||= '{{ CHAPTER_AUTHOR }}'
      }
    end

    def setup(options)
      self.title = options[:title]
      self.subtitle = options[:subtitle]
      self.author = options[:author]
      self.reference = options[:reference]
      self.cover_path = options[:cover_path]
      create_array
    end
  end
end
