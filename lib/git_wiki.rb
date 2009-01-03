begin
  require 'mojombo-grit'
rescue LoadError => e
  require 'grit'
end
  
include Grit

class GitWiki
  VERSION = '1.0.0'

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