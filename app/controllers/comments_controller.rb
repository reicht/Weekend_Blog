class CommentsController < ApplicationController
  def initialize(target)
    @target=target
    @params = @target[:params]
  end

  def index
    @post_list = $post_list
    render_template 'comments/index.html.erb'
  end

  def show
    comment = targetting
    if comment
      if @target[:format] == "json"
        render comment.to_json
      else
        @comment = comment
        render_template 'view_task.html.erb'
      end
    else
      render_not_found
    end
  end

  def create
    $comment_list << Comment.new(@params["body"])
    render({ message: "Successfully created new comment!" }.to_json)
  end

  def update
    comment = targetting

    if comment
      unless @params["body"].nil? || @params["body"].empty?
        comment.body = @params["body"]
      end

      unless @params["completed"].nil? || @params["completed"].empty?
        comment.completed = @params["completed"]
      end

      render comment.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy
    comment = targetting

    if task
      $post_list.delete(comment)
      render({ message: "Successfully Deleted Comment" }.to_json)
    else
      render_not_found
    end
  end

  def complete_task
    @params["completed"] = "true"
    update
  end

  private

  def targetting
    $comment_list.find { |comment|  post.id == @params[:id].to_i}
  end

  def render_not_found
    return_message = {
      message: "Comment not found!",
      status: '404'
    }.to_json

    render return_message, status: "404 NOT FOUND"
  end
end
