class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

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
      devise_parameter_sanitizer.for(:sign_up) << :user_birthday
    end

  # ログイン後のリダイレクト先の設定
  def after_sign_in_path_for(resource)
    if Restaurant.where(:user_id => current_user.id).count > 0
      root_path
    else
      new_restaurant_path
    end
  end

# url_text = Net::HTTP.get(URI.parse "http://www.w3schools.com/xml/note.xml")
# doc = Nokogiri::XML(url_text)



end
