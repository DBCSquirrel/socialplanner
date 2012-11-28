OmniAuth.config.logger = Rails.logger

#OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], scope: "email, publish_stream"
end