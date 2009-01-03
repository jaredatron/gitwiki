require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase

  def setup
    @mygitwiki = GitWiki.new( TMP_DIR + '/test_gitwiki_init' )
    Grit.debug = true
  end
  
  def teardown
    Grit.debug = false
  end

  def test_init
    assert_equal GitWiki, @mygitwiki.class
    assert_equal Grit::Repo, @mygitwiki.repo.class
    assert_equal true, File.exist?( @mygitwiki.repo.path )
    FileUtils.rm_rf( @mygitwiki.repo.path )
  end

  def test_add_page
    page = @mygitwiki['my_first_page']
    page_content = 'this is my first page'
    page.content = page_content
    page.save
  end
  
  def test_destroy_page
    assert true
  end

end