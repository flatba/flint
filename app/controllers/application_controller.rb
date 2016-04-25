class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ログインしていなければログインページヘリダイレクトする
  private
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  # name フィールドを許可する strong parameters の設定
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
    	# sign_upのときに、usernameも許可する
	    devise_parameter_sanitizer.for(:sign_up) << :name
	    devise_parameter_sanitizer.for(:sign_up) << :age_range
	    devise_parameter_sanitizer.for(:sign_up) << :gender

      # account_updateのときに、usernameも許可する
	    # devise_parameter_sanitizer.for(:account_update) << :name
	    # devise_parameter_sanitizer.for(:account_update) << :age
	    # devise_parameter_sanitizer.for(:account_update) << :sex
    end



end
