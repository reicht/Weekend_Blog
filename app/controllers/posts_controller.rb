class PostsController < ApplicationController
  def initialize(target)
    @target=target
    @params = @target[:params]
  end

  def index
    if @target[:format] == "json"
      render $post_list.to_json
    else
      render_template 'posts/index.html.erb'
    end
  end

  def show
    post = targetting
    if post
      if @target[:format] == "json"
        render post.to_json
      else
        @post = post
        render_template 'posts/show.html.erb'
      end
    else
      render_not_found
    end
  end

  def create
    $post_list << Post.new(@params["body"])
    render({ message: "Successfully created new post!" }.to_json)
  end

  def update
    post = targetting

    if post
      unless @params["body"].nil? || @params["body"].empty?
        post.body = @params["body"]
      end

      unless @params["completed"].nil? || @params["completed"].empty?
        post.completed = @params["completed"]
      end

      render post.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy
    post = targetting

    if task
      $post_list.delete(post)
      render({ message: "Successfully Deleted Post" }.to_json)
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
    $post_list.find { |post|  post.id == @params[:id].to_i}
  end

  def render_not_found
    return_message = {
      message: "Post not found!",
      status: '404'
    }.to_json

    render return_message, status: "404 NOT FOUND"
  end
end
