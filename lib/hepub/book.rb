require 'gepub'
require 'byebug'
require_relative 'metadata'
require_relative 'title_page'
require_relative 'cover'

class Book
  def initialize(metadata)
    @metadata = metadata
  end

  def generate(template_dir = 'epub_template')
    book = GEPUB::Book.new
    book.set_primary_identifier('http:/example.jp/bookid_in_url', 'BookID', 'URL')

    book.add_item('css/default.css', "#{template_dir}/css/default.css")

    Dir["#{template_dir}/images/*"].each do |image|
      book.add_item(image.to_s.gsub("#{template_dir}/", ''), image.to_s)
    end

    coverpage = Cover.new(metadata: @metadata, template_file: template_dir + '/cover.html')
    book.add_item('images/cover.png',@metadata.cover_path).cover_image
    book.add_ordered_item('cover.xhtml').add_content(StringIO.new(coverpage.to_s)) if File.exist? template_dir + '/cover.html'

    titlepage = TitlePage.new(metadata: @metadata, template_file: template_dir + '/title-page.html')
    book.add_ordered_item('title-page.xhtml').add_content(StringIO.new(titlepage.to_s)) if File.exist? template_dir + '/title-page.html'

    epubname = File.join(File.dirname(__FILE__), 'example_test_with_builder.epub')
    book.generate_epub(epubname)
  end
end

metadata = Metadata.new(options = {
                          title: 'Facebook e educação',
                          subtitle: 'publicar, curtir, compartilhar',
                          reference: 'PORTO, C., and SANTOS, E., orgs. <i>Facebook e educação</i>: publicar, curtir, compartilhar [online]. Campina Grande: EDUEPB, 2014. ISBN 978-85-7879-283-1. Available from SciELO Books &lt;<a href="http://books.scielo.org">http://books.scielo.org</a>&gt;.',
                          author: 'Cristiane Porto<br/>Edméa Santos<br/>(orgs.)',
                          cover_path: '/home/abner/work/hedra/livro-da-classe/public/system/default_covers/default_covers/000/000/001/original/image005.png'
                        })

book = Book.new(metadata)
book.generate
