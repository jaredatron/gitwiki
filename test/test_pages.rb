require File.dirname(__FILE__) + '/helper'

class TestPages < Test::Unit::TestCase

  include TestHelpers

  def setup
    flush_tmp_dir
    create_git_wiki
  end
  
  def teardown
    flush_tmp_dir
  end
  
  def test_page_full_name
    name = 'readme'
    ext  = 'rtf'
    @git_wiki[name, ext] = 'consider it read'
    page = @git_wiki[name]
    assert_equal name, page.name
    assert_equal ext, page.ext
    
    checkout_repo
    assert File.exists?( File.join( TEST_REPO, page.full_name ) )

    @git_wiki['folder/tree/is/nice', :xml]= '<doc />'
    assert_equal 'folder/tree/is/nice.xml', @git_wiki['folder/tree/is/nice'].full_name
    assert_equal '<doc />', @git_wiki['folder/tree/is/nice'].content
  end

  def test_add_and_modify_page
    name = 'howto'
    page = @git_wiki[name]

    page_content = 'this is how its done'
    page.content = page_content
    page.save
    assert_equal page_content, @git_wiki[name].content


    page_content = 'this is not how its done'
    page.content = page_content
    page.save
    assert_equal page_content, @git_wiki[name].content
  end
  
  def test_file_ext
    name = 'install'
    @git_wiki[name] = 'run some bash crap'
    page = @git_wiki[name]
    assert_equal 'txt', page.ext
    
    name = 'about'
    ext  = 'pdf'
    @git_wiki[name, ext] = 'puh puh puh pdf'
    page = @git_wiki[name]
    assert_equal ext, page.ext
    
    checkout_repo
    assert File.exists?( File.join( TEST_REPO, page.full_name ) )
    
    File.join(File.dirname(__FILE__), *%w[tmp])
  end
  
  def test_page_history
    name = "do/it/twice"
    name2 = "do/it/thrice"
    @git_wiki[name]="First"
    assert_equal 1, @git_wiki[name].history.length, "First commit to first file"
    @git_wiki[name]="Second"
    assert_equal 2, @git_wiki[name].history.length, "Second commit to first file"
    @git_wiki[name2]="first"
    assert_equal 1, @git_wiki[name2].history.length, "first commit to second file"
    @git_wiki[name2]="Second"
    assert_equal 2, @git_wiki[name2].history.length, "2nd commit to second file"
    assert_equal 4, @git_wiki.history_for("do").length
  end

end