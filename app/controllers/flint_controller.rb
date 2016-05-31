class FlintController < ApplicationController
	before_action :sign_in_required
	# helper_method :addLike

	def index
        if current_user.gender == "male"
            #異性のid一覧を取得
            gender_like_id = User.select(:id).where(:gender => "female")
        elsif current_user.gender == "female"
            #異性のid一覧を取得
            gender_like_id = User.select(:id).where(:gender => "male")
        else
            if current_user == nil
                redirect_to user_session_path
            else
                render :text => "something wrong"
            end
        end

        #ログインユーザーが、既にselectしている異性レストランid一覧を取得
        selected_gender_restraunt_id = UserLike.select(:restaurant_id).where(:user_id => current_user.id, :like_id => gender_like_id)
        same_gender_id = User.select(:id).where(:gender => current_user.gender)
        #selectされていない異性レストラン一覧を取得
        @candidates = Restaurant.where.not(:id => selected_gender_restraunt_id).where.not(:user_id => same_gender_id)
        # @users = User.where(:id => params[:id])
        @users = User.all
    end

    def new
    	@user_like = UserLike.new
    end


    def user
        facebook_uid = nil
        @current_user_candidates = Restaurant.where(:user_id => current_user.id)
        render :text => @current_user_candidates
        facebook_uid = User.find(current_user.id).uid

        if facebook_uid == nil
            # redirect_to root_path
        else
        @facebook_uid_thumb = "https://graph.facebook.com/"+ facebook_uid +"/picture?type=large"
        end
         @users = User.all
    end
    ### ↑たぶん、userメソッドとshowメソッドは一緒にできる。↓　###
    def show # クリックされたユーザのレストラン情報とサムネイル画像
        @select_user_candidate = Restaurant.where(:user_id => params[:id])
        @users = User.where(:id => params[:id])
        facebook_uid = User.find(params[:id]).uid
        @facebook_uid_thumb = "https://graph.facebook.com/"+ facebook_uid +"/picture?type=large"

    end

    def addLike # like側のuser_idとlikeされる側のuser_idをデータベース（user_like）に入れる
  		# モデルオブジェクトを生成
		# @user_like = UserLike.new
		# 属性を設定してモデルオブジェクトを生成
		# @user_like = UserLike.new(:user_id => 25 , :like_id => 28)
		# params変更


        #今回は、addlikeがrestaurantについておされるので、以下をしらべる
            # like_idがcurrent_userで
            # user_idが押した相手で
            # restaurant_idの店
        @match = UserLike.where(:user_id => params[:l_id], :like_id => current_user.id, :restaurant_id => params[:restaurant_id]).where.not(:matching => 0)

        if @match.exists?
            #すでに押されていて1:片方のみのいいねなら普通にマッチ
            if @match.first.matching == 1
                @match.first.update(:matching => 3)
            elsif @match.first.matching == 2
                @match.first.update(:matching => 4)
            end
            @match.first.save
            redirect_to root_path
        else
    		@user_like = UserLike.new(:user_id => current_user.id, :like_id => params[:l_id], :restaurant_id => params[:restaurant_id], :matching => params[:matching])
    		if @user_like.save

      		else
            	render 'new'
        	end
            redirect_to root_path # TOPページに戻る(POSTで送る場合変える必要ない？）
        end
    end

    def updateMatch
        UserLike.find(params[:userlike_id]).update(:matching => params[:matching])
        redirect_to root_path
    end

  #ログイン中ユーザーのマッチした一覧を表示
  def match
    @matches = UserLike.where(:user_id => current_user.id, :matching => 1)
  end


end

