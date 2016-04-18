Dir[File.dirname(__FILE__) + '/lib/*'].each { |file| require file }

puts 'Enter the source Wiki page'
starting_page = gets.chomp.strip

finder = Baconator.new(starting_page)
finder.go_find_bacon

if finder.goal_found
  puts '....'
  puts "The Bacon number for #{starting_page} is #{finder.bacon_number}."
  puts "The Bacon path is #{finder.bacon_path.join(" => ")}"
else
  puts "No bacon number found. Either we ran out of Wikipedia (doubtfull) or the limit was reached"
end
