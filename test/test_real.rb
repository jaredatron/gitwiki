require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase

  REPO_PATH = File.join(TMP_DIR, *%w[test_create_wiki.git])

  def setup
    Grit.debug = true
    FileUtils.rm_rf( REPO_PATH )
  end
  
  def teardown
    Grit.debug = false
    FileUtils.rm_rf( REPO_PATH )
  end
  
  def test_init_bare_repo
    repo = Repo.init_bare( REPO_PATH )
    assert_equal Grit::Repo, repo.class
  end
  
end