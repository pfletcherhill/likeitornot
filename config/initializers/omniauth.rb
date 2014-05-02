OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 
  ENV['FACEBOOK_APP_ID'], 
  ENV['FACEBOOK_SECRET'], 
  scope: "email,user_likes,user_photos,user_interests,user_friends"
end