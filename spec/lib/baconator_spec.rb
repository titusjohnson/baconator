RSpec.describe Baconator do
  describe '.go_find_bacon' do
    let(:bacon) { Baconator.new('https://en.wikipedia.org/wiki/Apollo_program') }

    it 'seeks and finds bacon per the given test case' do
      bacon.go_find_bacon
      expect(bacon.bacon_number).to eq(2)
      expect(bacon.bacon_path).to eq(['/wiki/Apollo_program', '/wiki/Apollo_13', '/wiki/Kevin_Bacon'])
    end
  end

  describe '.go_find_bacon when we start at Kevin\'s page' do
    let(:bacon) { Baconator.new('https://en.wikipedia.org/wiki/Kevin_Bacon') }

    it 'seeks and finds bacon' do
      bacon.go_find_bacon
      expect(bacon.bacon_number).to eq(0)
      expect(bacon.bacon_path).to eq(['/wiki/Kevin_Bacon'])
    end
  end

  
  describe '.go_find_bacon past the depth limit' do

    let(:bacon) { Baconator.new('https://en.wikipedia.org/wiki/Anne_Ward_(writer)') }
    
    it 'seeks and finds bacon' do
      bacon.go_find_bacon
      expect(bacon.bacon_path).to eq([])
      expect(bacon.bacon_number).to eq(0)
      expect(bacon.goal_found).to be false
    end
  end

  describe '.goal_found?' do
    let(:bacon) { Baconator.new('https://en.wikipedia.org/wiki/Apollo_program') }

    it 'returns false when given a dummy' do
      expect(bacon.goal_found?(Tree::TreeNode.new('/not/the/winner'))).to be false
    end

    it 'returns true when given a winner' do
      result = bacon.goal_found?(Tree::TreeNode.new(Baconator::GOAL_PAGE))
      expect(result).to be true
    end

    it 'logs the nodes depth and path to attributes when given a winner' do
      root   = Tree::TreeNode.new('/')
      winner = Tree::TreeNode.new(Baconator::GOAL_PAGE)
      root << winner
      bacon.goal_found?(winner)

      expect(bacon.bacon_number).to be 1
      expect(bacon.bacon_path).to eq ["/", "/wiki/Kevin_Bacon"]
    end
  end
end
