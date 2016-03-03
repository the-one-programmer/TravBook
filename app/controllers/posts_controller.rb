class PostsController < ApplicationController
  def create
    @post = @current_user.posts.build(post_params)
    if @post.save
      render json: { message: 'Post successfully created!' }, status: 200
    else
      render json: { message: @post.errors}, status: 400
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if (@post.nil?)
      render json: { message: 'User not found'}, status: 400
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      render json: { message: 'post successfully updated!' }, status: 200
    else
      render :error, status: 400
    end
  end

  def destroy
  end

  def like
    @post = Post.find_by_id(params[:id])
    if (@post.like(@current_user.id))
      render json: {message:"success"}, status:200
    else
      render json: {message:@post.errors}, status:400
    end
  end

  def unlike
    @post = Post.find_by_id(params[:id])
    if (@post.unlike(@current_user.id))
      render json: {message:"success"}, status:200
    else
      render json: {message:@post.errors}, status:400
    end
  end

  private

  def post_params
    params.permit(:content)
  end
end
