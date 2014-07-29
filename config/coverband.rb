require 'coverband'
baseline = Coverband.parse_baseline

Coverband.configure do |config|
  config.root              = Dir.pwd

  config.coverage_baseline = baseline
  # On heroku the app is kept at /app
  config.root_paths        = ['/app/']
  # This will ignore gems code
  config.ignore            = ['vendor']

  # This is what a real app setup would look like
  config.startup_delay     = Rails.env.production? ? 10 : 1
  config.percentage        = Rails.env.production? ? 15.0 : 100.0
  config.verbose           = Rails.env.production? ? false : true

  # But we just want to try out the gem
  #   Amount of requests coverband will ignore before collecting data
  config.startup_delay     = 1
  #   The percentage of requests coverband will kick in
  config.percentage        = 100.0
  config.verbose           = true

  if defined? Redis
    if ENV.key?('REDISTOGO_URL')
      # On heroku / when generating reports using production data
      config.redis = Redis.new(url: ENV["REDISTOGO_URL"])
    else
      # During development, connect to localhost
      config.redis = Redis.new
    end
  end
end
