Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'],ENV['FACEBOOK_APP_SECRET'], {scope: "first_name, gender, public_profile, user_friends, user_birthday"}
end
