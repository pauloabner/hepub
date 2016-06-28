require 'spec_helper'

RSpec.describe Hepub::Cover do
  let(:template_file) { 'spec/fixtures/file_cover_with_tags.html' }
  let(:metadata) { Hepub::Metadata.new(options={ title: 'Titulo', cover_path: 'images/cover.png' })}
  subject { Hepub::Cover.new(metadata: metadata, template_file: template_file) }

  describe '#to_s' do
    it 'replaces tags' do
      expect(subject.to_s).to eq Hepub::Util.file_to_str('spec/fixtures/file_cover.html')
    end
  end
end
