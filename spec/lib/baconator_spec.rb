RSpec.describe Baconator do
  describe '#extract_desired_links' do
    it 'returns only links that start with /wiki/' do
      links = [
        nil,
        '/wiki/European_Space_Agency',
        '//an.wikipedia.org/wiki/Programa_Apollo',
        'https://wikimediafoundation.org/'
      ]
      expect(Baconator.extract_desired_links(links)).to eq(['/wiki/European_Space_Agency'])
    end
  end

  describe '#whitelisted?' do
    it 'excludes links with a :' do
      expect(Baconator.whitelisted?('http://')).to eq(false)
    end

    it 'excludes links that do not start with /wiki/' do
      expect(Baconator.whitelisted?('/tom/wiki/page')).to eq(false)
    end

    it 'allows links that start with /wiki/' do
      expect(Baconator.whitelisted?('/wiki/google.com')).to eq(true)
    end
  end

  describe '.go_find_bacon' do
    let(:bacon) { Baconator.new('https://en.wikipedia.org/wiki/Apollo_program') }

    it 'seeks and finds bacon' do
      bacon.go_find_bacon
      expect(bacon.results).to eq(2)
    end
  end
end
