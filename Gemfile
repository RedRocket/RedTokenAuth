source 'https://rubygems.org'

# Declare your gem's dependencies in red_token_auth.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'mongoid', '~> 6.1.0'
gem 'bcrypt', '~> 3.1.7'

group :test, :development do
  gem "rspec-rails", "~> 3.5"
  gem 'factory_girl'
end

group :test do
  gem 'mongoid-rspec'
  gem 'mocha'
  gem 'database_cleaner'
end
