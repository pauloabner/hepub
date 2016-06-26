require 'spec_helper'

RSpec.describe Util do
  describe '#get_tags_from_string' do
    let(:string) { '<html><head></head><body></body></html>' }

    context 'when does not exist tags' do
      it 'returns an empty array' do
        expect(Util.tags_from_string(string)).to be_empty
      end

      context 'when string is nil' do
        let(:string) { nil }

        it 'returns an empty array' do
          expect(Util.tags_from_string(string)).to be_empty
        end
      end
    end

    context 'when exists tags' do
      let(:string) { '<html><head>{{ TITLE }}</head><body>{{ BODY }}</body></html>' }
      it 'returns an array' do
        expect(Util.tags_from_string(string)).to eq ['TITLE', 'BODY']
      end
    end
  end

  describe '#tags_from_file' do
    let(:file_name) { nil }

    context 'when file_name is nil' do
      it 'raise a exception' do
        expect { Util.tags_from_file file_name }.to raise_error IOError
      end
    end

    context 'when file_name is not found' do
      let(:file_name) { 'file_not_found.html' }
      it 'raise a exception' do
        expect { Util.tags_from_file file_name }.to raise_error IOError
      end
    end

    context 'when file_name exists' do
      context 'when no tag in the file' do
        let(:file_name) { 'spec/fixtures/file_without_tags.html' }
        it 'returns an empty array' do
          expect(Util.tags_from_file file_name).to be_empty
        end
      end

      context 'with tags in file' do
        let(:file_name) { 'spec/fixtures/file_with_tags.html' }

        it 'returns an array' do
          expect(Util.tags_from_file file_name).to eq ['TITLE', 'BODY']
        end
      end
    end
  end
end
