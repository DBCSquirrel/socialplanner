OmniAuth.config.logger = Rails.logger

OMNI_FILE = "#{Rails.root}/config/omniauth.yml"
if File.exists? OMNI_FILE
  OMNI_SETTINGS = YAML.load_file(OMNI_FILE)[Rails.env]
else
  OMNI_SETTINGS = ENV
end

#OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, OMNI_SETTINGS['APP_ID'], OMNI_SETTINGS['APP_SECRET'], scope: "email, publish_stream, create_event"
end