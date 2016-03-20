class PostsController < ApplicationController

  api :POST, '/list_post/:id', 'list all posts of a user'
  param :id,:number, desc: 'user id' ,:required => true

  def index
    @posts = Post.where(:user_id => params[:id]).paginate(:page => params[:page])
  end

  api :POST, '/new_post', 'Create new post'
  description 'Create a a post'
  param :content, String, desc: 'post content' ,:required => true

  def create
    @post = @current_user.posts.build(post_params)
    if @post.save
      render json: { message: 'Post successfully created!' }, status: 200
    else
      render json: { message: @post.errors}, status: 400
    end
  end

  api :GET, '/show_post/:id', 'show a post'
  description 'show a post'
  param :id,:number, desc: 'post id' ,:required => true

  def show
    @post = Post.find_by_id(params[:id])
    if (@post.nil?)
      render json: { message: 'Post not found'}, status: 400
    end
  end
  api :POST, '/update_post/:id', 'update a post'
  description 'update a  post'
  param :id,:number, desc: 'post id' ,:required => true
  param :content, String, desc: 'updated content' ,:required => true

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      render json: { message: 'post successfully updated!' }, status: 200
    else
      render :error, status: 400
    end
  end
  api :POST, '/delete_post/:id', 'Delete a post'
  description 'Delete a post'
  param :id,:number, desc: 'post id' ,:required => true

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
  api :POST, '/like_post/:id', 'like a post'
  description 'like a post'
  param :id,:number, desc: 'post id' ,:required => true

  def like
    @post = Post.find_by_id(params[:id])
    if (@post.like(@current_user.id))
      render json: {message:"success"}, status:200
    else
      render json: {message:@post.errors}, status:400
    end
  end

  api :POST, '/unlike_post/:id', 'unlike a post'
  description 'unlike a post'
  param :id,:number, desc: 'post id' ,:required => true


  def unlike
    @post = Post.find_by_id(params[:id])
    if (@post.unlike(@current_user.id))
      render json: {message:"success"}, status:200
    else
      render json: {message:@post.errors}, status:400
    end
  end
  api :POST, '/repost/:id', 'make repost'
  param :id,:number, desc: 'original post id' ,:required => true
  param :content, String, desc: 'repost content'

  def repost
    @post = @current_user.posts.build(post_params)
    op = Post.find_by_id(params[:id])
    if (op)
      if (op.original_post_id == nil)
        @post.original_post_id = params[:id]
      else
        @post.original_post_id = op.original_post_id
      end
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
