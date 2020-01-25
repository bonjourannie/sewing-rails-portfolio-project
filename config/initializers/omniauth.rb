Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITGUB_KEY'], ENV['GITHUB_SECRET']
end