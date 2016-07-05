require 'spec_helper'

RSpec.describe Hepub::TitlePage do
  let(:template_file) { 'spec/fixtures/file_with_tags.html' }
  let(:metadata) { Hepub::Metadata.new(options={ title: 'TITLE' }) }
  subject { Hepub::TitlePage.new(metadata, template_file) }

  describe '#to_s' do
    it 'replace templates tags' do
      expect(subject.to_s).to eq "<html><head>TITLE</head><body>{{ BODY }}</body></html>\n"
    end
  end

  describe '#tags' do
    it 'returns an array with all tags' do
      expect(subject.tags).to eq ['TITLE', 'BODY']
    end
  end
end
