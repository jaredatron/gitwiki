class GitWiki::Page
  
  def initialize(gitwiki, name, opts={})
    @gitwiki = gitwiki
    @name = name
    @content = opts[:content]
    @ext = opts[:ext]
  end
  
  attr_accessor :name, :content, :ext
  
  def ext
    @ext.to_s
  end

  def full_name
    "#{name}.#{ext}"
  end

  def save( commit_message=nil )
    @gitwiki.save_page( self, commit_message )
  end
  
  def history
    @gitwiki.history_for full_name
  end
end