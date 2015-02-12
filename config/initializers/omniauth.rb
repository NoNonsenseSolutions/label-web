OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "794834980601346", "69cfdc634d643f4b341bf45a4535174b"
end