require 'json'

class Comment
  attr_accessor :body, :id, :parent_id

  def initialize()

  end

  def not_found
    return "Not Found".to_json
  end

  def to_json(_ = nil)
    {
      id: id,
      body: body,
      parent_id: parent_id,
    }.to_json
  end

end
