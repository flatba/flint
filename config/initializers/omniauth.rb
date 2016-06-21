Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "id", "pass", {scope: "user_birthday"}
end
