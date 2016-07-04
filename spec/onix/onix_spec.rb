# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Hepub::Onix do
  let(:onix_file) { File.open('spec/fixtures/onix_file.xml') }
  subject { Hepub::Onix.new onix_file }

  describe '#to_s' do
    it 'returns a string' do
      expect(subject.to_s.class).to eq String
    end

    it 'returns a string in onix xml format' do
      xml = subject.to_s
      xml_header = '<?xml version="1.0" encoding="utf-8"?>'
      expect(xml).to match /\<\?xml version="1.0" encoding="utf-8"\?\>/
      expect(xml).to match /\<!DOCTYPE ONIXMessage SYSTEM "http:\/\/www\.editeur\.org\/onix\/2\.1\/reference\/onix\-international\.dtd"\>/
    end
  end

  describe '#check?' do
    it 'it has all main nodes' do
      expect(subject.check?).to be_truthy
    end
    context 'with invalid file' do
      let(:onix_file) { File.open('spec/fixtures/file_with_tags.html') }
      it 'returns false' do
        expect(subject.check?).to be_falsy
      end
    end
  end

  describe '#metadata' do
    it 'returns a Hepu::Metadata object' do
      expect(subject.metadata.class).to eq Hepub::Metadata
    end

    context 'check metadata values' do
      let(:metadata) { subject.metadata }

      it { expect(metadata.value_of('TITLE')).to eq 'Colonização agrária no Norte do Paraná: processos geoeconômicos e sociogeográficos de desenvolvimento de uma zona subtropical do Brasil sob a influência da plantação de café' }
      it { expect(metadata.value_of('AUTHOR')).to eq 'Kohlhepp, Gerd' }
    end
  end
end
