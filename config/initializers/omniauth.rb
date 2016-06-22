Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'],ENV['FACEBOOK_APP_SECRET'], {:client_options => {:ssl => {:verify => false}}}
end
