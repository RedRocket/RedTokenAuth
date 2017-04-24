module RedTokenAuth
  class Engine < ::Rails::Engine
    isolate_namespace RedTokenAuth

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
