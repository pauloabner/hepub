module Hepub
  require 'gepub'
  require 'byebug'
  class Book
    def initialize(metadata, template_dir = 'epub_template')
      @metadata = metadata
      setup(template_dir)
    end

    def generate(template_dir = 'epub_template')
      epubname = File.join(File.dirname(__FILE__), 'example_test_with_builder.epub')
      @epub.generate_epub(epubname)
    end

    private

    def setup(template_dir)
      @epub = GEPUB::Book.new
      @epub.set_primary_identifier('http:/example.jp/bookid_in_url', 'BookID', 'URL')
      cssSetup(template_dir)
      imagesSetup(template_dir)
      coverSetup(template_dir)
      titleSetup(template_dir)
    end

    def cssSetup(template_dir)
      @epub.add_item('css/default.css', "#{template_dir}/css/default.css")
    end

    def imagesSetup(template_dir)
      Dir["#{template_dir}/images/*"].each do |image|
        @epub.add_item(image.to_s.gsub("#{template_dir}/", ''), image.to_s)
      end
    end

    def coverSetup(template_dir)
      coverpage = Hepub::Cover.new(metadata: @metadata, template_file: template_dir + '/cover.html')
      @epub.add_item('images/cover.png',@metadata.cover_path).cover_image
      @epub.add_ordered_item('cover.xhtml').add_content(StringIO.new(coverpage.to_s)) if File.exist? template_dir + '/cover.html'
    end

    def titleSetup(template_dir)
      titlepage = Hepub::TitlePage.new(metadata: @metadata, template_file: template_dir + '/title-page.html')
      @epub.add_ordered_item('title-page.xhtml').add_content(StringIO.new(titlepage.to_s)) if File.exist? template_dir + '/title-page.html'
    end
  end
end
