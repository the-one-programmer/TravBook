class RepliesController < ApplicationController

  def create

  end

  private
  def reply_params
    params.permit(:content,:reply_to)
  end
end
