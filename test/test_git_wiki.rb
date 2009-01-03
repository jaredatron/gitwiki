class TestGitWiki < Test::Unit::TestCase
  def setup
    @git = Git.new(File.join(File.dirname(__FILE__), *%w[..]))
  end
  
  def teardown
    Grit.debug = false
  end
end