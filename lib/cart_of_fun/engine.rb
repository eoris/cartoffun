require 'aasm'
require 'jquery-rails'
require 'turbolinks'
require 'simple_form'
require 'bootstrap-sass'
require 'sass-rails'

module CartOfFun
  class Engine < ::Rails::Engine
    isolate_namespace CartOfFun

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
