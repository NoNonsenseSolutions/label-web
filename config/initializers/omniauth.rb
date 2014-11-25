OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "750951388323039", "280178269f5613bfdd6e49ffb9d7c7c1"
end