require File.join(File.dirname(__FILE__), *%w[.. lib git_wiki])

require 'rubygems'
require 'test/unit'

include Grit

module Helpers

  TMP_DIR   = File.join(File.dirname(__FILE__), *%w[tmp])
  TEST_REPO = File.join( TMP_DIR, 'test_repo' )

  def flush_tmp_dir
    Dir["#{TMP_DIR}/*"].each{|f| FileUtils.rm_rf(f) }
  end

  def create_git_wiki
    @git_wiki = GitWiki.new( TEST_REPO )
  end

  def checkout_repo
    `git clone #{@git_wiki.repo.path} #{TEST_REPO}`
  end
  
  def tree
    `tree #{TEST_REPO}`
  end
  
end