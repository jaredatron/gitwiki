require File.dirname(__FILE__) + '/helper'

class TestGitWikiInit < Test::Unit::TestCase

  include TestHelpers
  
  def setup
    flush_tmp_dir
    create_git_wiki
    Grit.debug = true
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
  
  def test_repo_for_dot_git_ext
    gw = GitWiki.new( File.join( TMP_DIR, 'i_have_no_dot_git_ext' ) )
    assert !!(gw.repo.path =~ /\.git$/)
  end
  
  def test_that_you_cannot_find_pages_with_ext
    assert_not_equal @git_wiki['/mama/baby.txt'].path, @git_wiki['/mama/baby'].path
  end
  
  def test_does_having_your_slashes_going_the_other_way_break_everything
    assert_equal @git_wiki['\i\love\your\face'].path, '\\i\\love\\your\\face'
  end

end