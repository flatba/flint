Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "id", "pass", {scope: "public_profile, user_friends, user_birthday"}
end
