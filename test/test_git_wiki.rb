require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase


  REPO_PATH = File.join(TMP_DIR, *%w[test_gitwiki_init])
  CO_PATH =   File.join(TMP_DIR, *%w[test_co_gitwiki_init])

  def setup
    `rm -rf #{TMP_DIR}/*`
    Grit.debug = true
    @mygitwiki = GitWiki.new( REPO_PATH )
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
    puts "git clone #{@mygitwiki.repo.path} #{CO_PATH}"
    puts `git clone #{@mygitwiki.repo.path} #{CO_PATH}`
    
    puts "tree:"
    puts `tree #{CO_PATH}`

  
  end

  # def test_add_page
  #   page = @mygitwiki['my_first_page']
  #   page_content = 'this is my first page'
  #   page.content = page_content
  #   page.save
  # end
  # 
  # def test_destroy_page
  #   assert true
  # end

end