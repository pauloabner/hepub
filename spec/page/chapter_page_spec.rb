require 'spec_helper'

RSpec.describe Hepub::ChapterPage do
  let(:template_file) { 'spec/fixtures/file_chapter_page_tags.html' }
  let(:metadata) { Hepub::Metadata.new(options={ title: 'Titulo Principal' })}
  let(:chapter) { Hepub::Chapter.new('Titulo do Capítulo', 'Autor do Capítulo')}
  subject { Hepub::ChapterPage.new(metadata, template_file, chapter) }

  describe '#to_s' do
    it 'replaces tags' do
      page = subject.to_s
      expect(page).to include 'Titulo Principal'
      expect(page).to include 'Titulo do Capítulo'
      expect(page).to include 'Autor do Capítulo'
    end

    context 'with sections' do
      before do
        chapter.add_section('Autor da Seção', 'Conteúdo da Seção')
      end

      it 'shows sections contents' do
        page = subject.to_s
        expect(page).to include 'Titulo Principal'
        expect(page).to include 'Titulo do Capítulo'
        expect(page).to include 'Autor do Capítulo'
        expect(page).to include 'Autor da Seção'
        expect(page).to include 'Conteúdo da Seção'
      end
    end
  end
end
