require 'json'

class Post
  attr_accessor :title, :body, :id, :published, :local_comments, :comment_ids

  def initialize(title, body, id = -1)
    @title = title
    @body = body
    @local_comments = []
    @comment_ids = 0
    if id == -1
      @id = Post.get_id
    else
      @id = id
    end
    $post_list << self
    @local_comments << $comment_list
  end

  def Post.setup(num)
    id = Post.get_id
    title = $starter_post_titles[num]
    body = $starter_post_contents[num]
    parent = Post.new(title, body, id)
    3.times do |x|
      Comment.setup(parent)
    end
  end


  def not_found
    return "Not Found".to_json
  end

  def to_json( _ = nil)
    {
      id: id,
      body: body,
      completed: completed
    }.to_json
  end

  def comment_id
    @comment_ids += 1
  end

  private

  def Post.get_id
    $post_ids += 1
  end

end
