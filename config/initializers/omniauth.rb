Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "id", "pass", {scope: "first_name, gender, public_profile, user_friends, user_birthday"}
end
