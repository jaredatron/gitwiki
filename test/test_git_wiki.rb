require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase

  def setup
    Grit.debug = true
  end
  
  def teardown
    Grit.debug = false
  end

  def test_init
    mygitwiki = GitWiki.new( TMP_DIR + '/test_gitwiki_init' )
    assert_equal GitWiki, mygitwiki.class
    assert_equal Grit::Repo, mygitwiki.repo.class
    assert_equal true, File.exist?( mygitwiki.repo.path )
    FileUtils.rm_rf( mygitwiki.repo.path )
  end
  
end