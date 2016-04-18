RSpec.describe Scraper do
  let(:scraper) { Scraper.new }
  
  describe 'extracting links from a page' do
    it 'loads the contents of each link into its internal property for access' do
      expect(scraper).to receive(:fetch_html).and_return("<strong>Some crap
        <a href='bob_and_tom'>whut</a>
        <a href='the_morning_show'>no, just no</a>
        </strong></i>
        <a prop='not_an_href'></a>")

      links = scraper.scrape_page_for_links 'http://somepage.com'
      expect(links).to eq ['bob_and_tom', 'the_morning_show', nil]

      # Firing for a different page resets context
      expect(scraper).to receive(:fetch_html).and_return("")
      links = scraper.scrape_page_for_links 'http://somelink.com'
      expect(links).to eq []
    end
  end

  describe 'checking if we care about a link with .whitelisted_link?' do
    it 'rejects blank, empty, or media pages' do
      expect(scraper.whitelisted_page?('')).to be false
      expect(scraper.whitelisted_page?(nil)).to be false
      expect(scraper.whitelisted_page?('/wiki/William_O%27Connell_Bradley#/media/File:William-O.-Bradley.jpg')).to be false
    end

    it 'allows wiki pages' do
      expect(scraper.whitelisted_page?('/wiki/William_O%27Connell_Bradley')).to be true
    end
  end

  describe '.find_unique_linked_pages' do
    let(:unique_links) { scraper.find_unique_linked_pages('/wiki/William_O%27Connell_Bradley') }
    
    it 'returns an array of links with no duplicates' do
      expect(unique_links.length).to eq(274)
      expect(unique_links).to eq(unique_links.uniq)
    end
  end
end
