$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
require 'grit.rb'
require 'git_wiki/page'

class GitWiki
  VERSION = '0.0.1'
  DEFAULT_PAGE_TYPE = :txt
  
  attr_reader :repo
    
  def initialize(path, opts={})
    @path = "#{path}.git"
    @repo = find_or_create_repo
    @default_page_type = opts[:default_page_type] or GitWiki::DEFAULT_PAGE_TYPE
  end
  
  def [](page_name)
    page = find_or_create_page(page_name)
  end

  def []=(page_name, contents)
    page = find_or_create_page(page_name)
    page.contents = contents
    page.save
  end
  
  def find_or_create_page(page_name)
    find_page(page_name) || Page.new( self, page_name, \
                                      :type => @default_page_type )
  end
  
  def find_page(page_name)
    dirpath = File.dirname(page_name)
    dir = if dirpath == '.' 
            repo.tree 
          else
            repo.tree / dirpath
          end
    return nil unless dir

    filename = File.basename(page_name)+'.*'
    blob = dir.contents.detect do |item|
             File.fnmatch(filename, item.name)
           end
    return nil unless blob 
    
    ext = File.extname(blob.name).to_sym
    Page.new(self, page_name, {:type => ext, :content => blob.data })
  end
  
private
  def find_or_create_repo
    Grit::Repo.new(@path)
  rescue Grit::NoSuchPathError, Grit::InvalidGitRepositoryError
    Grit::Repo.init_bare(@path)
  end
  
end
