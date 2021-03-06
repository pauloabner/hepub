# frozen_string_literal: true
# Hepub
module Hepub
  require 'gepub'
  # Book
  class Book
    attr_accessor :onix_xml
    attr_reader :pages

    def initialize(metadata, template_dir = 'epub_template')
      @metadata = metadata
      @count_chapter = 0
      @template_dir = template_dir
      @pages = pages_config(template_dir)
      setup(template_dir)
    end

    def generate(output_filepath = nil)
      epubname = output_filepath.present? ? output_filepath : File.join(File.dirname(__FILE__), 'EBOOK.epub')
      @epub.generate_epub(epubname)
      epubname
    rescue Exception => e
      logger.info "Erro generating epub"
      logger.info e
      nil
    end

    def add_chapter(title, author, sections = [])
      chapter = chapter_setup(title, author, sections)
      ch_page_filepath = "#{@template_dir}/chapter-page.html"
      chapter_page = Hepub::ChapterPage.new(@metadata, ch_page_filepath, chapter)
      item = @epub.add_ordered_item("#{@count_chapter}.xhtml")
      item.add_content(StringIO.new(chapter_page.to_s)).toc_text(title)
      @count_chapter += 1
      chapter.count_sections
    end

    def onix_xml=(file)
      onix = Hepub::Onix.new(file)
      @metadata = onix.metadata
      setup(@template_dir)
    end

    private

    def setup(template_dir)
      @epub = GEPUB::Book.new
      @epub.set_primary_identifier('http:/example.jp/bookid', 'BookID', 'URL')
      css_setup(template_dir)
      images_setup(template_dir)
      cover_setup(template_dir)
      title_setup(template_dir) if pages.include? 'titlepage'
      isbn_setup(template_dir) if pages.include? 'isbnpage'
    end

    def css_setup(template_dir)
      @epub.add_item('css/default.css', "#{template_dir}/css/default.css")
    end

    def images_setup(template_dir)
      Dir["#{template_dir}/images/*"].each do |image|
        @epub.add_item(image.to_s.gsub("#{template_dir}/", ''), image.to_s)
      end
    end

    def cover_setup(template_dir)
      cover_path = "#{template_dir}/cover.html"
      coverpage = Hepub::CoverPage.new(@metadata, cover_path)
      add_cover_to_epub(cover_path, coverpage)
    end

    def title_setup(template_dir)
      tp_path = "#{template_dir}/title-page.html"
      titlepage = Hepub::TitlePage.new(@metadata, tp_path)
      if File.exist? tp_path
        ordered_item = @epub.add_ordered_item('title-page.xhtml')
        ordered_item.add_content(StringIO.new(titlepage.to_s))
      end
    end

    def cover_path?
      @metadata.cover_path != '{{ COVER_PATH }}'
    end

    def chapter_setup(title, author, sections)
      chapter = Hepub::Chapter.new(title, author)
      sections.each do |section|
        chapter.add_section(section[:title], section[:content])
      end
      chapter
    end

    def add_cover_to_epub(cover_path, coverpage)
      if cover_path?
        @epub.add_item('images/cover.png', @metadata.cover_path).cover_image
      end

      if File.exist? cover_path
        ordered_item = @epub.add_ordered_item('cover.xhtml')
        ordered_item.add_content(StringIO.new(coverpage.to_s))
      end
    end

    def pages_config template_dir
      config_filepath = template_dir + '/pages.conf'
      arr = []
      return arr unless File.exists? config_filepath
      f = File.read(config_filepath)
      f.each_line do |line|
        arr.push(line.gsub("\r\n",'').gsub("\n",''))
      end
      arr
    end

    def isbn_setup template_dir
      ip_path = "#{template_dir}/isbn-page.html"
      if File.exist? ip_path
        isbnpage = Hepub::IsbnPage.new(@metadata, ip_path)
        ordered_item = @epub.add_ordered_item('isbn-page.xhtml')
        ordered_item.add_content(StringIO.new(isbnpage.to_s))
      end
    end
  end
end
