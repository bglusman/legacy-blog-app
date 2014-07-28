require 'coverband'
Coverband.configure
require 'coverband/tasks'

namespace :coverband do
  namespace :heroku do
    desc 'Collect code coverage from production app'
    task :coverage do
      redis_url = nil
      Bundler.with_clean_env do
        redis_url = `heroku config:get REDISTOGO_URL`.strip
        $stdout.print 'Downloading baseline from production app... '
        `heroku run "bash -c 'rake coverband:baseline &>/dev/null && cat tmp/coverband_baseline.json'" 2>/dev/null 1> tmp/coverband_baseline.json.tmp`
        `tail -n +2 tmp/coverband_baseline.json.tmp > tmp/coverband_baseline.json`
        $stdout.puts 'DONE'
      end
      if redis_url.present?
        sh "REDISTOGO_URL='#{redis_url}' rake coverband:coverage"
      else
        puts 'Could not fetch the redis URL from heroku!'
        exit 1
      end
    end

    desc 'Clean up code coverage stats from production app'
    task :clear do
      Bundler.with_clean_env do
        sh "heroku run rake coverband:clear"
      end
    end
  end
end
