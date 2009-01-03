require File.dirname(__FILE__) + '/helper'

class TestGitWiki < Test::Unit::TestCase

  REPO_PATH = File.join(TMP_DIR, *%w[test_create_wiki.git])
  CO_PATH = File.join(TMP_DIR, *%w[test_create_wiki])

  def setup
    Grit.debug = true
    FileUtils.rm_rf( REPO_PATH )
    FileUtils.rm_rf( CO_PATH )
  end
  
  def teardown
    Grit.debug = false
    FileUtils.rm_rf( REPO_PATH )
    FileUtils.rm_rf( CO_PATH )
  end
  
  def test_init_bare_repo
    # repo = Repo.init_bare( REPO_PATH )
    # assert_equal Grit::Repo, repo.class



    puts `git --git-dir=#{REPO_PATH} init`

    puts File.exist?( REPO_PATH )
    repo = Grit::Repo.new(REPO_PATH)
    index = repo.index
    index.add('foo/bar/baz.txt', 'hello!')
    index.add('foo/qux/bam.txt', 'world!')
    puts index.commit('first commit')

    puts "checking out repo"
    puts `git clone #{REPO_PATH} #{CO_PATH}`

    puts "tree:"
    puts `tree #{CO_PATH}`
    
  end
  
end