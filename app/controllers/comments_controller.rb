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
    # @comment = targetting
    # @parent = $post_list[@comment.parent_id]
    # render_template 'comments/show.html.erb'
  end

  def create
    target = @params[:post].to_i
    post = $post_list[target - 1]
    Comment.new(@params["comment"],post )
    redirect_to '/comments'
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

    if comment
      $post_list.delete(comment)
      render({ message: "Successfully Deleted Comment" }.to_json)
    else
      render_not_found
    end
  end

  def new
    render_template 'comments/new.html.erb'
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
