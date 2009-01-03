$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
require 'grit.rb'
include Grit

class GitWiki
  VERSION = '0.0.1'

  def initialize(path)
    @path = "#{path}.git"
  end
  
  def repo
    @repo ||= find_or_create_repo
  end
  
  def [](page_name)
    Page.new( repo, page_name )
  end
  
  private
  
  def find_or_create_repo
    Grit::Repo.new(@path)
  rescue Grit::NoSuchPathError, Grit::InvalidGitRepositoryError
    Grit::Repo.init_bare(@path)
  end
  
end