require_relative 'lib/helpers.rb'
require_relative 'lib/scraper.rb'

puts 'Enter the source Wiki page'
starting_page = gets.chomp.strip

bacon_finder = Baconator.new(starting_page)
bacon_finder.go_find_bacon
puts bacon_finder.results

# puts "Seeking bacon from #{starting_page}"
# scraper.scrape(starting_page)

# page_count = 1
# found_links = Helpers.extract_desired_links(scraper.links)
# link_tree = {}

# unless found_links.include? 'https://en.wikipedia.org/wiki/Kevin_Bacon'
#   page_count += 1
#   puts "Bacon not found. Page count going to #{page_count}"
#   link_tree[starting_page] = {}

#   found_links.each do |link|
#     url = "https://en.wikipedia.org" << link

#     puts "Seeking bacon from #{url}"

#     scraper.scrape url
#     sub_page_links = Helpers.extract_desired_links(scraper.links)
    
#     unless sub_page_links.include? 'https://en.wikipedia.org/wiki/Kevin_Bacon'
#       link_tree[starting_page]
#     end

#     sleep(1)
#   end
# else
#   puts "Bacon found at #{starting_page}"
# end
