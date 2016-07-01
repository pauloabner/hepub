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

  describe '#add_options' do
    it 'add tags value' do
      options = {
                  title: 'Facebook e educação',
                  subtitle: 'publicar, curtir, compartilhar',
                  reference: 'PORTO, C., and SANTOS, E., orgs. <i>Facebook e educação</i>: publicar, curtir, compartilhar [online]. Campina Grande: EDUEPB, 2014. ISBN 978-85-7879-283-1. Available from SciELO Books &lt;<a href="http://books.scielo.org">http://books.scielo.org</a>&gt;.',
                  author: 'Cristiane Porto<br/>Edméa Santos<br/>(orgs.)',
                  cover_path: '/home/abner/work/hedra/livro-da-classe/public/system/default_covers/default_covers/000/000/001/original/image005.png'
                }
      subject.add_options options
      expect(subject.value_of('TITLE')).to eq 'Facebook e educação'
      expect(subject.value_of('SUBTITLE')).to eq 'publicar, curtir, compartilhar'
      expect(subject.value_of('REFERENCE')).to eq 'PORTO, C., and SANTOS, E., orgs. <i>Facebook e educação</i>: publicar, curtir, compartilhar [online]. Campina Grande: EDUEPB, 2014. ISBN 978-85-7879-283-1. Available from SciELO Books &lt;<a href="http://books.scielo.org">http://books.scielo.org</a>&gt;.'
      expect(subject.value_of('AUTHOR')).to eq 'Cristiane Porto<br/>Edméa Santos<br/>(orgs.)'
      expect(subject.value_of('COVER_PATH')).to eq '/home/abner/work/hedra/livro-da-classe/public/system/default_covers/default_covers/000/000/001/original/image005.png'
    end
  end
end
