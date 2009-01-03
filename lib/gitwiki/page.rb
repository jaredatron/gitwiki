class GitWiki::Page
  
  def initialize(repo, name)
    @repo = repo
    @name = name
  end
  
  attr_reader :repo, :name
  
  def blob
    blob ||= find_or_create_blob
  end
  
  def path
    File.join( repo.path, name )
  end
  
  def content
    blob.data
  end
  
  def new?
    blob.id.nil?
  end

  def saved?
    !new?
  end
  
  def content=(new_content)
    return if new_content == content
    File.open(path, 'w') { |f| f << new_content }
    Dir.chdir(repo.path) { repo.add(name) }
    repo.commit_index( new? ? "Adding #{name}" : "Creating #{name}" )
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