class FlintController < ApplicationController
	before_action :sign_in_required
	# helper_method :addLike

	def index
        ##################################################################
        # 一旦COする。restaurantモデルにuser_idを加えたデータをpullしてから対応
        ##################################################################
        # @matches = UserLike.where(:user_id => current_user.id, :matching => 1)
        # if current_user.gender = "male"
        #     #異性のid一覧を取得
        #     gender_like_id = User.select(:id).where(:gender => "famale")
        # elsif current_user.gender = "famale"
        #     #異性のid一覧を取得
        #     gender_like_id = User.select(:id).where(:gender => "male")
        # else
        #     render :text => "Something Wrong."
        # end
        # #ログインユーザーが、既にselectしている異性レストランid一覧を取得
        # selected_gender_restraunt_id = UserLike.select(:restaurant_id).where(:user_id => current_user.id, :like_id => gender_like_id)
        # #selectされていない異性レストラン一覧を取得
        # @candidates = Restaurant.where.not(:id => selected_gender_restraunt_id).where.not(:user_id => current_user.id)
        @candidates = Restaurant.all
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
        @match = UserLike.where(:user_id => current_user.id, :like_id => params[:u_id])

        if @match.exists?
            @match.first.matching = 1
            @match.first.save
            redirect_to root_path
        else
    		@user_like = UserLike.new(:user_id => current_user.id, :like_id => params[:l_id])
    		if @user_like.save

      		else
            	render 'new'
        	end
            redirect_to root_path # TOPページに戻る(POSTで送る場合変える必要ない？）
        end
    end

  #ログイン中ユーザーのマッチした一覧を表示
  def match
    @matches = UserLike.where(:user_id => current_user.id, :matching => 1)
  end

end















