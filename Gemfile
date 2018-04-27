source 'https://rubygems.org'

ruby '2.3.7'

gem 'travis-support',  git: 'https://github.com/travis-ci/travis-support'
gem 'travis-config',   '~> 1.0.0'
gem 'travis-metrics',  git: 'https://github.com/travis-ci/travis-metrics'

gem 'sidekiq',         '~> 5.1.3'
gem 'redis-namespace'

gem 'sinatra',         '~> 2.0.1'
gem 'rake',            '~> 0.9.2.2'
gem 'multi_json'

gem 'sentry-raven'

gem 'activesupport',   '~> 4.1.11'

# backports 2.5.0 breaks rails routes
gem 'backports',       '2.4.0'

# structures
gem 'yajl-ruby',       '~> 1.3.1'

# heroku
gem 'unicorn',         '~> 5.4.0'

group :development, :test do
  gem 'pry'
  gem 'rspec',         '~> 2.9'
end

group :development do
  gem 'foreman',       '~> 0.41.0'
end

group :test do
  gem 'rack-test'
  gem 'webmock'
end
