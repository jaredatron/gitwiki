$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed
require 'grit.rb'

class GitWiki
  VERSION = '0.0.1'
  DEFAULT_PAGE_EXT = :txt
  
  attr_reader :repo
  attr_accessor :default_page_ext
    
  def initialize(path, opts={})
    @path = "#{path}.git"
    @repo = find_or_create_repo
    @default_page_ext = opts[:default_page_ext] || GitWiki::DEFAULT_PAGE_EXT
  end
  
  def [](page_name)
    page = find_or_create_page(page_name)
  end

  def []=(*attribs)
    if attribs.length == 2
      page_name, contents = attribs
      ext = nil
    else
      page_name, ext, contents = attribs
    end
    
    page = find_or_create_page(page_name)
    page.contents = contents
    page.ext = ext if ext
    page.save
  end
  
  def find_or_create_page(page_name)
    find_page(page_name) || Page.new( self, page_name, \
                                      :ext => @default_page_ext )
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
    Page.new(self, page_name, {:ext => ext, :content => blob.data })
  end
  
  def save_page( page, commit_message=nil )
    repo.index.add( page.full_name, page.content )
    repo.index.commit( commit_message || "updaing page '#{page.full_name}' at #{Time.now}" )
    self
  end
  
private
  def find_or_create_repo
  #   Grit::Repo.new(@path)
  # rescue Grit::NoSuchPathError, Grit::InvalidGitRepositoryError
  #   # `git --git-dir=#{@path} init`
  #   # @repo = Grit::Repo.new(@path)
    Grit::Repo.init_bare(@path)
  end
  
end

require 'git_wiki/page'