require 'json'

class Post
  attr_accessor :title, :body, :id, :published

  def initialize()

  end

  def not_found
    return "Not Found".to_json
  end

  def to_json(_ = nil)
    {
      id: id,
      body: body,
      completed: completed
    }.to_json
  end

  private

  def Task.get_id
    $given_ids += 1
  end
end
