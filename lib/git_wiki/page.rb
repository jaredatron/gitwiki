class GitWiki::Page
  
  def initialize(gitwiki, name, opts={})
    @gitwiki = gitwiki
    @name = name
    @content = opts[:content]
    @ext = opts[:ext]
  end
  
  attr_reader :name, :content, :ext

  def full_name
    "#{name}.#{ext}"
  end

  def content
    @content
  end
  
  def content=(new_content)
    @content = new_content
  end
    
  def new?
    blob.id.nil?
  end

  def saved?
    !new?
  end
  
  def save( commit_message=nil )
    @gitwiki.save_page( self, commit_message )
  end
    
  
  private
  
  def find_or_create_blob
    find_blob || create_blob
  end

  def find_blob
    repo.tree/name
  end

  def create_blob
    Grit::Blob.create(repo, :name => name, :data => '')
  end
  
end