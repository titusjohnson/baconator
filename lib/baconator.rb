require 'tree'

class Baconator
  attr_reader :bacon_number, :bacon_path, :seen_pages, :goal_found, :opts

  GOAL_PAGE = '/wiki/Kevin_Bacon'

  def initialize(starting_url, options = {})
    @starting_page = starting_url.split('.org').last
    @scraper = Scraper.new
    @bacon_tree = Tree::TreeNode.new(@starting_page)
    @goal_found = false

    @bacon_number = 0
    @bacon_path = []
    @seen_pages = []

    @opts = {
      maximum_depth: 3,
      seek_method: :breadth,
      debug: false
    }

    @opts.merge! options
  end

  def go_find_bacon
    return if goal_found?(@bacon_tree)
    if opts[:seek_method] == :breadth
      breadth_walk(@bacon_tree)
    else
      parse_node @bacon_tree
      depth_walk(@bacon_tree)
    end
  end

  # 
  # Do a breadth-first walk of the bacon tree
  # 
  # @param node [Tree::TreeNode] the tree node to begin parsing
  def breadth_walk(node)
    node.breadth_each do |child|
      puts "Inspecting #{child.name} for Bacon." if opts[:debug]
      parse_node child unless child.node_depth == opts[:maximum_depth] - 1
      return if @goal_found
    end
  end

  # 
  # Do a depth-first walk of the bacon tree
  # Depending on the depth allowed, this seems much slower by default
  # 
  # @param node [Tree::TreeNode] the tree node to begin parsing
  def depth_walk(node)
    return if node.node_depth == opts[:maximum_depth] - 1

    node.children.each do |child|
      puts "Inspecting #{child.name} for Bacon." if opts[:debug]
      parse_node child
      return if @goal_found

      depth_walk child
    end
  end

  #
  # Given tree node, retrieve all links for the page, check their bacon status,
  # then add unseen links as children of the current node.
  # 
  # @param node [Tree::TreeNode]
  # 
  # @return [Tree::TreeNode]
  def parse_node(node)
    pages = @scraper.find_unique_linked_pages node.name
    pages = pages - @seen_pages
    @seen_pages.concat pages

    pages.each do |page|
      new_page_node = Tree::TreeNode.new(page)
      node << new_page_node
      return if goal_found?(new_page_node)
    end

    node
  end

  # 
  # Check if a node is the goal
  # Set attributes if the node is the goal
  # 
  # TODO: I'm not overly happy with this method, it's doing things
  #       outside of its named mandate.
  # 
  # @param page [Tree::TreeNode]
  # 
  # @return [Boolean]
  def goal_found?(page)
    if page.name == GOAL_PAGE
      @goal_found = true
      @bacon_number = page.node_depth

      @bacon_path << page.name
      @bacon_path.concat page.parentage.map { |n| n.name } if page.parentage
      @bacon_path.reverse!
    end

    goal_found
  end
end
