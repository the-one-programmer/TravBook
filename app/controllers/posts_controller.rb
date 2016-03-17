class PostsController < ApplicationController

  def index
    @posts = Post.where(:user_id => params[:id]).paginate(:page => params[:page])
  end

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
      render json: { message: 'Post not found'}, status: 400
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
    @post = Post.find_by_id(params[:id])
    if (@post==nil)
      render json: { message: 'Post not found'}, status: 400
      return
    end
    if @post.destroy
      render json: {message:"success"}, status:200
    else
      render json: {message:@post.errors}, status:400
    end

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

  def repost
    @post = @current_user.posts.build(post_params)
    op = Post.find_by_id(params[:id])
    if (op)
      if (op.original_post_id == nil)
        @post.original_post_id = params[:id]
      else
        @post.original_post_id = op.original_post_id
      end

      @post.content = op.content
    else
      render json: { message: 'Original post does not exist'}, status: 400
    end

    if @post.save
      render json: { message: 'Post successfully created!' }, status: 200
    else
      render json: { message: @post.errors}, status: 400
    end
  end

  private

  def post_params
    params.permit(:content)
  end

end
