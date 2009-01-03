require File.dirname(__FILE__) + '/helper'

class TestGitWikiInit < Test::Unit::TestCase

  include TestHelpers
  
  def setup
    Grit.debug = true
    flush_tmp_dir
    create_git_wiki
  end
  
  def teardown
    flush_tmp_dir
    Grit.debug = false
  end

  def test_init
    assert_equal GitWiki, @git_wiki.class
    assert_equal Grit::Repo, @git_wiki.repo.class
    assert_equal true, File.exist?( @git_wiki.repo.path )
    assert_equal 1, @git_wiki.repo.commits.size
  end

end