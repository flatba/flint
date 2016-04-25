class FlintController < ApplicationController
	before_action :sign_in_required
	# helper_method :addLike

	def index
		@user = User.all
        @matches = UserLike.where(:user_id => params[:current], :matching => 1)
    end

    def new
    	@user_like = UserLike.new	
    end

    def addLike # like側のuser_idとlikeされる側のuser_idをデータベース（user_like）に入れる
  		# モデルオブジェクトを生成
		# @user_like = UserLike.new
		# 属性を設定してモデルオブジェクトを生成
		# @user_like = UserLike.new(:user_id => 25 , :like_id => 28)
		# params変更
        @match = UserLike.where(:user_id => params[:l_id], :like_id => params[:u_id])

        if @match.exists?
            @match.first.matching = 1
            @match.first.save
            redirect_to root_path
        else
    		@user_like = UserLike.new(:user_id => params[:u_id], :like_id => params[:l_id])
    		if @user_like.save

      		else
            	render 'new'
        	end
            redirect_to root_path # TOPページに戻る(POSTで送る場合変える必要ない？）
        end
    end

  #ログイン中ユーザーのマッチした一覧を表示
  def match
    @matches = UserLike.where(:user_id => params[:current], :matching => 1)
  end

end















