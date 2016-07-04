require 'spec_helper'

RSpec.describe Hepub::Metadata do
  subject { Hepub::Metadata.new(options={ title: 'TITULO' }) }
  describe '#value_of' do
    it 'returns de correct value' do
      expect(subject.value_of('TITLE')).to eq 'TITULO'
    end

    context 'when tag no exists' do
      it 'returns {{ NO_TAG }}' do
        expect(subject.value_of('NO_TAG')).to eq '{{ NO_TAG }}'
      end
    end
  end

  describe '#change_value' do
    it 'changes the value' do
      subject.change_value('TITLE', 'TITULO TROCADO')
      expect(subject.value_of('TITLE')).to eq 'TITULO TROCADO'
    end
  end
end
