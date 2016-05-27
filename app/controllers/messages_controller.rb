class MessagesController < ApplicationController

  def show
    @userlike = UserLike.find(params[:id])
    @matching = @userlike.matching

    if @userlike.like.gender == "male"
      @payment_user = @userlike.like
    elsif @userlike.liker.gender == "male"
      @payment_user = @userlike.liker
    end

    if @matching <= 2 # 奢るよと男から言っている
      @user_id = @userlike.user_id
      @like_id = current_user.id
    elsif @matching == 3 # 普通にマッチ
      if current_user.gender == "male"
        @user_id = @userlike.user_id
        @like_id = current_user.id
      elsif current_user.gender == "female"
        @user_id = current_user.id
        @like_id = @userlike.like_id
      end
    elsif @matching == 4 # 男から女へ、奢るよという誘いがあってマッチ成立
      if current_user.gender == "male"
        @user_id = current_user.id
        @like_id = @userlike.like_id
      elsif current_user.gender == "female"
        @user_id = @userlike.user_id
        @like_id = current_user.id
      end
    else
      render text: "something wrong"
    end
      @messages = Message.where(:user_like_id => @userlike.id)
  end

  # 書き込み
  def create
    userlike = UserLike.where(:id => params[:id]).first
    if userlike.user_id == current_user.id
      receiver_id = userlike.like_id
    elsif userlike.like_id == current_user.id
      receiver_id = userlike.user_id
    else
      render text: "something wrong"
    end
  	@message = Message.create(:user_like_id => params[:id], :body => params[:body], :sender_id => current_user.id, :receiver_id => receiver_id)
    redirect_to message_path(params[:id])
  end

end
