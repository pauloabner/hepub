require 'spec_helper'

RSpec.describe Cover do
  let(:template_file) { 'spec/fixtures/file_cover_with_tags.html' }
  let(:metadata) { Metadata.new(options={ title: 'Titulo', cover_path: 'images/cover.png' })}
  subject { Cover.new(metadata: metadata, template_file: template_file) }

  describe '#to_s' do
    it 'replaces tags' do
      expect(subject.to_s).to eq Util.file_to_str('spec/fixtures/file_cover.html')
    end
  end
end
