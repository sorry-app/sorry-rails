lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sorry/rails/version"

Gem::Specification.new do |spec|
    spec.name          = "sorry-rails"
    spec.version       = Sorry::Rails::VERSION
    spec.authors       = ["Robert Rawlins"]
    spec.email         = ["robert@sorryapp.com"]

    spec.summary       = "Add the Sorry™ website plugin to your Rails application."
    spec.description   = "Display status updates from your Sorry™ status page to your users, and affectively customize which notices each user should see."
    spec.homepage      = "https://github.com/sorry-app/sorry-rails"
    spec.license       = "MIT"

    spec.add_development_dependency "bundler", "~> 1.16"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rspec", "~> 3.0"
end
