# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Hepub::Book do
  let(:metadata) { Hepub::Metadata.new(options: { title: 'TITULO' }) }
  subject { Hepub::Book.new(metadata) }
  describe '#add_chapter' do
    it 'add chapter without sections' do
      chapter_counter = subject.add_chapter('Titulo do Cap', 'Autor do Cap')
      expect(chapter_counter).to eq 0
    end

    it 'add chapter with sections' do
      sections = [{ title: 'Titulo Seção 1', content: 'Conteúdo Seção 1' },
                  { title: 'Titulo Seção 2', content: 'Conteúdo Seção 2' }]
      chapter_counter = subject.add_chapter('Titulo do Cap',
                                            'Autor do Cap', sections)

      expect(chapter_counter).to eq 2
    end
  end

  describe '#onix_xml' do
    it 'add onix xml file' do
      expect(subject.onix_xml = 'spec/fixtures/onix_file.xml').to eq 'spec/fixtures/onix_file.xml'
    end
  end
end
