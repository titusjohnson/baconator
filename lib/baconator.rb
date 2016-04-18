require 'tree'

class Baconator
  attr_reader :bacon_number, :bacon_path, :seen_pages, :goal_found

  GOAL_PAGE = '/wiki/Kevin_Bacon'
  MAXIMUM_DEPTH = 3

  def initialize(starting_url)
    @starting_page = starting_url.split('.org').last
    @scraper = Scraper.new

    @bacon_tree = Tree::TreeNode.new(@starting_page)
    @goal_found = false

    @bacon_number = 0
    @bacon_path = []
    @seen_pages = []
  end

  def go_find_bacon
    return if goal_found?(@bacon_tree)
    walk_tree(@bacon_tree)
  end

  # 
  # Do a breadth-first walk of the bacon tree
  # 
  # @param node [Tree::TreeNode] the tree node to begin parsing
  def walk_tree(node)
    node.breadth_each do |child|
      puts "Inspecting #{child.name} for Bacon. The Number is currently #{child.node_depth}"
      parse_node child
      return if @goal_found
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
    if node.node_depth == MAXIMUM_DEPTH
      puts "#{node.name} is at max depth, cannot continue."
      return
    end

    pages = @scraper.find_unique_linked_pages node.name
    pages = pages - seen_pages
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
