

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, '193467880799348', '799b7d4d2b5bb906293cb6a30c405d45', 
  provider :facebook, Rails.configuration.fb_app_id, Rails.configuration.fb_app_secret,
  {:scope => 'publish_actions, publish_stream,email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}} 
end

