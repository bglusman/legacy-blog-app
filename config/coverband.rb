require 'coverband'
baseline = Coverband.parse_baseline

Coverband.configure do |config|
  config.root              = Dir.pwd
  config.coverage_baseline = baseline
  # config.root_paths        = ['/app/']
  config.ignore            = ['vendor']
  # Since rails and other frameworks lazy load code. I have found it is bad to allow
  # initial requests to record with coverband. This ignores first 10 requests
  config.startup_delay     = Rails.env.production? ? 10 : 1
  config.percentage        = Rails.env.production? ? 15.0 : 100.0
  config.verbose           = Rails.env.production? ? false : true
  if defined? Redis
    config.redis = Redis.new
  end
end
