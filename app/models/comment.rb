require 'json'

class Comment
  attr_accessor :body, :id, :parent_id, :timestamp

  def initialize(body, parent, id = -1)
    @timestamp = Time.now.strftime("at %H:%M %y/%m/%d")
    @parent = parent
    @parent_id = parent.id
    @body = body
    @parent.comments << self
    if id == -1
      @id = parent.comment_id
    else
      @id = id
    end
  end

  def Comment.setup(parent)
    @parent = parent
    parent_comments = $starter_comments[parent.id-1]
    id = Comment.get_id
    body = parent_comments[id - 1]
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
    @parent.comment_id
  end

end
