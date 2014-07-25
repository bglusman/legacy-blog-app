Jumpup::Heroku.configure do |config|
  config.app = 'legacy-blog-app'
end if Rails.env.development?