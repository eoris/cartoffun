$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cart_of_fun/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cart_of_fun"
  s.version     = CartOfFun::VERSION
  s.authors     = ["eoris"]
  s.email       = ["eoris.work@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CartOfFun."
  s.description = "TODO: Description of CartOfFun."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "turbolinks"
  s.add_dependency "aasm"
  s.add_dependency "simple_form"
  s.add_dependency "rails-assets-bootstrap"
  s.add_dependency "sass-rails", "~> 5.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "devise"
  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
end
