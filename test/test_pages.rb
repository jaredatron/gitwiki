require File.dirname(__FILE__) + '/helper'

class TestPages < Test::Unit::TestCase
  REPO_PATH = File.join(TMP_DIR, *%w[test_gitwiki_init])
  CO_PATH =   File.join(TMP_DIR, *%w[test_co_gitwiki_init])

  def setup
    `rm -rf #{TMP_DIR}/*`
    @mygitwiki = GitWiki.new( REPO_PATH )
  end
  
  def teardown
    FileUtils.rm_rf( @mygitwiki.repo.path )
  end

  def test_add_and_modify_page
    page = @mygitwiki['my_first_page']
    page_content = 'this is my first page'
    page.content = page_content
    page.save
    debug_repo
    assert_equal @mygitwiki['my_first_page'].content, page_content
    @mygitwiki['folder/tree/is/nice', :xml]= '<doc />'
    assert_equal @mygitwiki['folder/tree/is/nice'].full_name, 'folder/tree/is/nice.xml'
    assert_equal @mygitwiki['folder/tree/is/nice'].content, '<doc />'
  end
  
private
  def debug_repo
    puts "checking out repo"
    puts "git clone #{@mygitwiki.repo.path} #{CO_PATH}"
    puts `git clone #{@mygitwiki.repo.path} #{CO_PATH}`
    
    puts "tree:"
    puts `tree #{CO_PATH}`
  end
end