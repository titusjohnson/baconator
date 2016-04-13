class Helpers
  #
  # Wikipedia uses relative links for everything we care about
  # And has lots of other links we don't care about.
  # Return only the subset of desired wiki pages
  def self.extract_desired_links(links)
    links.reduce([]) do |subset, link| 
      subset << link if link && link[0..5] == '/wiki/'
      subset
    end
  end
end
