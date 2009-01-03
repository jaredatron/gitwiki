require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase

  REPO_PATH = TMP_DIR + '/test_gitwiki_init'
  CO_PATH = TMP_DIR + '/test_co_gitwiki_init'

  def setup
    @mygitwiki = GitWiki.new( REPO_PATH )
    Grit.debug = true
  end
  
  def teardown
    Grit.debug = false
    FileUtils.rm_rf( @mygitwiki.repo.path )
    FileUtils.rm_rf( CO_PATH )
  end

  def test_init
    assert_equal GitWiki, @mygitwiki.class
    assert_equal Grit::Repo, @mygitwiki.repo.class
    assert_equal true, File.exist?( @mygitwiki.repo.path )
    
    puts "checking out repo"
    puts `git clone #{REPO_PATH} #{CO_PATH}`
    
    puts "tree:"
    puts `tree #{CO_PATH}`

  
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