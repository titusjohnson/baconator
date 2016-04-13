require_relative '../../lib/helpers'

RSpec.describe Helpers do
  describe '#extract_desired_links' do
    it 'returns only links that start with /wiki/' do
      links = [
        nil,
        '/wiki/European_Space_Agency',
        '//an.wikipedia.org/wiki/Programa_Apollo',
        'https://wikimediafoundation.org/'
      ]
      expect(Helpers.extract_desired_links(links)).to eq(['/wiki/European_Space_Agency'])
    end
  end
end
