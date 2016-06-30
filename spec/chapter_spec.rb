require 'spec_helper'

RSpec.describe Hepub::Chapter do
  subject { Hepub::Chapter.new('title', 'author') }

  it { expect(subject.author).to eq 'author' }

  it { expect(subject.title).to eq 'title' }

  describe '#add_section' do
    it 'returns a array' do
      arr = subject.add_section('title', 'content')
      expect(arr.class).to eq Array
    end

    it 'returns an array with section added' do
      arr = subject.add_section('title', 'content')
      expect(arr.count).to eq 1
      expect(arr).to match_array [{:title=>'title', :content=>'content'}]
    end

    it 'retuns array in the correct sequence' do
      subject.add_section('title', 'content')
      arr = subject.add_section('title1', 'content1')
      expect(arr.count).to eq 2
      expect(arr.first).to include(:title=>'title', :content=>'content')
      expect(arr.last).to include(:title=>'title1', :content=>'content1')
    end
  end

  describe '#count_sections' do
    it 'returns the number of sections' do
      expect(subject.count_sections).to eq 0
      subject.add_section('title', 'content')
      expect(subject.count_sections).to eq 1
      subject.add_section('title', 'content')
      expect(subject.count_sections).to eq 2
    end
  end
end
