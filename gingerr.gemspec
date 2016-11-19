$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gingerr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gingerr"
  s.version     = Gingerr::VERSION
  s.authors     = ["hspazio"]
  s.email       = ["pitinofabio@gmail.com"]
  s.homepage    = "https://github.com/hspazio/gingerr"
  s.summary     = "Easily manage system status and error reports"
  s.description = "Easily manage system status and error reports"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
