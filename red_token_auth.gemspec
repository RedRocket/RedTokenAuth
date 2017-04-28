$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "red_token_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "red_token_auth"
  s.version     = RedTokenAuth::VERSION
  s.authors     = ["Caio Ergos"]
  s.email       = ["caioergos@gmail.com"]
  s.summary     = "Simple token based authentication for Mongoid."
  s.description = "Simple token authentication designed to work with mongoid. This gem simply provides a simple interface for authentication."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "mongoid", "~> 6.1.0"
  s.add_dependency "bcrypt", "~> 3.1.7"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.5"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "mongoid-rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "database_cleaner"
end
