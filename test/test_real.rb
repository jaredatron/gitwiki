require File.dirname(__FILE__) + '/helper'

class TestReal < Test::Unit::TestCase

  include TestHelpers
  
  def setup
    Grit.debug = true
    flush_tmp_dir
  end
  
  def teardown
    Grit.debug = false
    flush_tmp_dir
  end
  
  def test_init_bare_repo
    repo_path = TEST_REPO+'.git'
    # assert_equal "Initialized empty Git repository in #{repo_path}/\n", 
    `git --git-dir=#{repo_path} init`

    assert File.exist?( repo_path )
    repo = Grit::Repo.new(repo_path)
    index = repo.index
    index.add('foo/bar/baz.txt', 'hello!')
    index.add('foo/qux/bam.txt', 'world!')
    puts index.commit('first commit')
    
    assert_equal 'first commit', repo.commits.first.message
  
    `git clone #{repo_path} #{TEST_REPO}`    
    assert File.exists?( File.join( TEST_REPO, 'foo/bar/baz.txt' ) ) 
    assert File.exists?( File.join( TEST_REPO, 'foo/qux/bam.txt' ) ) 
  end
  
  def test_multiple_commits
    repo_path = TEST_REPO+'.git'
    # assert_equal "Initialized empty Git repository in #{repo_path}/\n", 
    `git --git-dir=#{repo_path} init`

    assert File.exist?( repo_path )
    repo = Grit::Repo.new(repo_path)
    index = repo.index
    index.add('foo/bar/baz.txt', 'hello!')
    index.add('foo/qux/bam.txt', 'world!')
    parent = index.commit('first commit')

    index.add('foo2/bar2/baz2.txt', 'hello!')
    index.add('foo2/qux2/bam2.txt', 'world!')
    puts index.commit('second commit', parent)
    
    assert_equal 2, repo.commits.length  
  end
  
end