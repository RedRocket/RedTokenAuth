$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "red_token_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "red_token_auth"
  s.version     = RedTokenAuth::VERSION
  s.authors     = ["Caio Ergos"]
  s.email       = ["caioergos@gmail.com"]
  s.summary     = "Simple token based authentication interface."
  s.description = "This does not aim to compete with Devise. It is intended to supply a simple interface for database agnostic authentication."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
