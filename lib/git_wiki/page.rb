class GitWiki::Page
  
  def initialize(gitwiki, name, opts={})
    @gitwiki = gitwiki
    @name = name
    @content = opts[:content]
    @ext = opts[:ext]
  end
  
  attr_accessor :name, :content, :ext

  def full_name
    "#{name}.#{ext}"
  end

  def save( commit_message=nil )
    @gitwiki.save_page( self, commit_message )
  end
end