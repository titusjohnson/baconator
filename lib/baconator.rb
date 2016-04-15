require 'tree'
require 'scraper'

class Baconator
  attr_reader :results

  def initialize(starting_url, goal_page = '/wiki/Kevin_Bacon')
    @starting_page = pageize(starting_url)
    @goal_page = goal_page

    @bacon_tree = Tree::TreeNode.new(@starting_page)
    @scraper = Scraper.new
    @results = 0
    @goal_found = false
  end

  def go_find_bacon
    if @starting_page == @goal_page
      @goal_found = true
      return
    end
    
    @results += 1

    parse_node(@bacon_tree)
    return if @goal_found
    iterate_node(@bacon_tree)
    return if @goal_found
  end

  def collect_links(url)
    Baconator.extract_desired_links(@scraper.scrape(url))
  end

  def pageize(url)
    url.split('.org').last
  end

  def iterate_node(node)
    @results += 1

    node.children.each do |child|
      parse_node(node)
      return if @goal_found
    end

    return if @results == 5
  end

  def parse_node(node)
    node_links = collect_links(node.name).uniq

    node_links.each do |link|
      page = pageize(link)
      if page == @goal_page
        @goal_found = true
        return
      end
      @bacon_tree << Tree::TreeNode.new(page) rescue nil
    end
  end

  #
  # Wikipedia uses relative links for everything we care about
  # And has lots of other links we don't care about.
  # Return only the subset of desired wiki pages
  def self.extract_desired_links(links)
    links.reduce([]) do |subset, link| 
      subset << link if whitelisted? link
      subset
    end
  end

  def self.whitelisted?(link)
    return false unless link
    # Links with a : are media pages
    return false if /:/.match link
    link[0..5] == '/wiki/' ? true : false
  end
end
