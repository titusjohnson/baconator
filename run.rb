require_relative 'lib/helpers.rb'
require_relative 'lib/scraper.rb'

puts 'Enter the source Wiki page'
starting_page = gets.chomp.strip

scraper = Scraper.new

puts "Seeking bacon from #{starting_page}"
scraper.scrape(starting_page)

page_count = 1
found_links = Helpers.extract_desired_links(scraper.links)
puts found_links


