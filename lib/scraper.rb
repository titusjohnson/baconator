require 'httparty'
require 'nokogiri'

class Scraper
  attr_reader :url, :links, :html

  def initialize
    reset
  end

  def scrape(url)
    reset

    @url = url

    page = Nokogiri::HTML(fetch_html(url))

    @links = page.css('a').map { |link| link['href'] }
  end

  def fetch_html(url)
    req = HTTParty.get(url)
    return req.body
  end

private

  def reset
    @url = ''
    @links = []
  end
end
