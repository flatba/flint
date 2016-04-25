class MessagesController < ApplicationController

  def show
    @like_id = UserLike.find(params[:id]).like_id
    @match = UserLike.where(:user_id => params[:current], :like_id => @like_id, :matching => 1).first
    @messages = Message.where(:user_like_id => @match.id)
  end

  # 書き込み
  def create
  	@message = Message.create(:user_like_id => 2, :body => params[:body])
    redirect_to message_path(params[:id])
  end
  
end
