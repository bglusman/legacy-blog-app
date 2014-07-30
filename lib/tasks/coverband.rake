require 'coverband'
Coverband.configure

# Coverband default tasks
require 'coverband/tasks'

# Coverband tasks to collect data from Heroku
namespace :coverband do
  namespace :heroku do
    desc 'Check if the current git revision is the same as the code deployed to heroku on'
    task :check_same_revision do
      if `git status --porcelain`.strip != ''
        $stdout.puts "Git tree is dirty!"
        exit 1
      end
      sh 'git fetch heroku'
      if `git diff HEAD heroku/master --name-only | wc -l`.strip.to_i != 0
        $stdout.puts "The current revision is different from the code that has been deployed to heroku!"
        exit 1
      end
    end

    desc 'Download baseline data from heroku'
    task :baseline do
      Bundler.with_clean_env do
        success = false
        $stdout.puts ('*' * 80)
        $stdout.puts 'Downloading baseline from production app... '
        sh 'heroku run "bash -c \'rake coverband:baseline &>/dev/null && cat tmp/coverband_baseline.json\'" 2>/dev/null 1> tmp/coverband_baseline.json.tmp'
        sh 'tail -n +2 tmp/coverband_baseline.json.tmp > tmp/coverband_baseline.json'
        $stdout.puts 'DONE!'
      end
    end

    desc 'Collect code coverage from production app'
    task :coverage => [:check_same_revision, :baseline] do
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

    desc 'Clean up code coverage stats from production app'
    task :clear do
      Bundler.with_clean_env do
        sh "heroku run rake coverband:clear"
      end
    end
  end
end
