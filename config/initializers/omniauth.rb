require 'omniauth-openid'
require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, "FACEBOOK_APP_ID","FACEBOOK_APP_SECRET ", {:client_options => {:ssl => {:verify => false}}}

   # generic openid
   provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp')
   provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
   provider :open_id, :name => 'yahoo', :identifier => 'yahoo.co.jp'
   provider :open_id, :name => 'mixi', :identifier => 'mixi.jp'
end
