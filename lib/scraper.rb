require 'httparty'
require 'nokogiri'

class Scraper
  attr_reader :url, :links, :html

  WIKIPEDIA_URL = 'https://en.wikipedia.org'

  # 
  # Given a page, fetch out a unique list of outbound links
  # 
  # @param page [String] a /wiki/Page_URL
  # 
  # @return [Array]
  def find_unique_linked_pages(page)
    links = scrape_page_for_links page
    extract_desired_links(links).uniq
  end

  # 
  # Given a page url, fetch out all outbound links from that page
  # @param page [String] a /wiki/Page_URL
  # 
  # @return [Array] of /wiki/Linked_Pages
  def scrape_page_for_links(page)
    page_dom = Nokogiri::HTML(fetch_html(WIKIPEDIA_URL + page))
    page_dom.css('a').map { |link| link['href'] }
  end

  def fetch_html(url)
    req = HTTParty.get(url)
    return req.body
  end

  #
  # Wikipedia uses relative links for everything we care about
  # and has lots of other links we don't care about.
  # Return only the subset of desired wiki pages
  # 
  # @param links [type] [description]
  # 
  # @return [type] [description]
  def extract_desired_links(links)
    links.reduce([]) do |subset, page| 
      subset << page if whitelisted_page? page
      subset
    end
  end

  # 
  # Verify that a given relative page URL is something that will
  # lead us to bacon.
  # 
  # - Some page links have no href attribute, leading to empty submissions
  # - Relative wikipedia links with a : in them are media pages
  # - We only care about relative links that start with /wiki/
  # 
  # @param link [String] a /wiki/Page_Url_string
  # 
  # @return [Boolean]
  def whitelisted_page?(page)
    return false unless page
    return false if /:/.match page
    page[0..5] == '/wiki/' ? true : false
  end
end
