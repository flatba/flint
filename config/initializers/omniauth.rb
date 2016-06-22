Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "FACEBOOK_APP_ID","FACEBOOK_APP_SECRET ", {:client_options => {:ssl => {:verify => false}}}
end
