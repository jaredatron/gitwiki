$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
require 'grit.rb'

class GitWiki
  VERSION = '0.0.1'
  DEFAULT_PAGE_TYPE = :txt
  
  def initialize(path, opts={})
    @path = "#{path}.git"
    @repo = find_or_create_repo
    @default_page_type = opts[:default_page_type] or GitWiki::DEFAULT_PAGE_TYPE
  end
  
  attr_reader :repo
  
  def [](page_name)
    Page.new( repo, page_name, :type => @default_page_type )
  end

  private

  def find_or_create_repo
    Grit::Repo.new(@path)
  rescue Grit::NoSuchPathError, Grit::InvalidGitRepositoryError
    Grit::Repo.init_bare(@path)
  end
  
end

require 'git_wiki/page'