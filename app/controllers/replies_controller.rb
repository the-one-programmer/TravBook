class RepliesController < ApplicationController

  api :POST, '/reply/:id', 'Create reply'
  description 'Create a reply under a post'
  param :id,:number, desc: 'post that replies to' ,:required => true
  param :content, String, desc: 'reply content' ,:required => true
  param :reply_to,String, desc: 'id of the user replying to',:required => true

  def create
    @post = Post.find_by_id(params[:id])
    if (@post == nil)
      render json: { message: "Post is not found"}, status: 400
    end
    @reply = @post.replies.build(reply_params)
    @reply.user_id = @current_user.id
    if @reply.save
      render json: { message: 'Reply successfully created!' }, status: 200
    else
      render json: { message: @reply.errors}, status: 400
    end
  end

  api :POST, '/delete_reply/:id', 'delete reply'
  description 'delete a reply under a post'
  param :id,:number, desc: 'the id of the reply' ,:required => true

  def destroy
    @reply = Reply.find_by_id(params[:id])
    if (@reply==nil)
      render json: { message: 'Reply not found'}, status: 400
      return
    end
    if @reply.destroy
      render json: {message:"success"}, status:200
    else
      render json: {message:@reply.errors}, status:400
    end
  end

  private
  def reply_params
    params.permit(:content,:reply_to)
  end
end
