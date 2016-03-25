require 'json'

class Comment
  attr_accessor :body, :id, :parent_id

  def initialize(body, parent, id = -1)
    @parent_id = parent.id
    @body = body
    if id == -1
      @id = parent.comment_id
    else
      @id = id
    end
  end

  def Comment.setup(parent)
    id = Comment.get_id
    body = $starter_comments[parent.id-1[id-1]]
    Comment.new(body, parent, id)
  end

  def not_found
    return "Not Found".to_json
  end

  def to_json( _ = nil)
    {
      id: id,
      body: body,
      parent_id: parent_id,
    }.to_json
  end

  private

  def Comment.get_id
    $comment_ids +=
  end

end
