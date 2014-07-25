require 'coverband'
Coverband.configure
require 'coverband/tasks'

namespace :coverband do
  desc 'Collect code coverage from production app'
  task :heroku do
    redis_url = nil
    Bundler.with_clean_env do
      redis_url = `heroku config:get REDISTOGO_URL`.strip
    end
    if redis_url.present?
      sh "REDISTOGO_URL='#{redis_url}' rake coverband:coverage"
    else
      puts 'Could not fetch the redis URL from heroku!'
      exit 1
    end
  end
end
