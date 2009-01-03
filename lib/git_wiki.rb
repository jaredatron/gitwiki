$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
require 'grit.rb'

class GitWiki
  VERSION = '0.0.1'

  def initialize(path)
    @path = "#{path}.git"
  end
  
  def repo
    @repo ||= find_or_create_repo
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
    find_page(page_name) || Page.new( self, page_name )
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
    
    ext = File.extname(blob.name)
    Page.new(self, page_name, {:ext => ext, :content => blob.data })
  end
  
private
  
  def find_or_create_repo
    Grit::Repo.new(@path)
  rescue Grit::NoSuchPathError, Grit::InvalidGitRepositoryError
    Grit::Repo.init_bare(@path)
  end
  
end