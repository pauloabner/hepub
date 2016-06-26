require 'spec_helper'

RSpec.describe TitlePage do
  let(:template_file) { 'spec/fixtures/file_with_tags.html' }
  let(:metadata) { Metadata.new(options={ title: 'TITLE' }) }
  subject { TitlePage.new(template_file: template_file, metadata: metadata) }

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
