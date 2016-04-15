RSpec.describe Scraper do
  describe 'extracting links from a page' do
    let(:scraper) { Scraper.new }

    it 'loads the contents of each link into its internal property for access' do
      expect(scraper).to receive(:fetch_html).and_return("<strong>Some crap
        <a href='bob_and_tom'>whut</a>
        <a href='the_morning_show'>no, just no</a>
        </strong></i>
        <a prop='not_an_href'></a>")

      scraper.scrape 'http://somelink.com'
      expect(scraper.links).to eq ['bob_and_tom', 'the_morning_show', nil]

      # Firing for a different page resets context
      expect(scraper).to receive(:fetch_html).and_return("")
      scraper.scrape 'http://somelink.com'
      expect(scraper.links).to eq []
    end
  end
end
