# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sorry/rails/version'

Gem::Specification.new do |spec|
    spec.name          = 'sorry-rails'
    spec.version       = Sorry::Rails::VERSION
    spec.authors       = ['Robert Rawlins']
    spec.email         = ['robert@sorryapp.com']

    spec.summary       = 'Add the Sorry™ website plugin to your Rails application.'
    spec.description   = 'Display status updates from your Sorry™ status page to your users, and affectively customize which notices each user should see.'
    spec.homepage      = 'https://github.com/sorry-app/sorry-rails'
    spec.license       = 'MIT'

    spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)

    spec.add_development_dependency 'bundler'
    spec.add_development_dependency 'faker'
    spec.add_development_dependency 'rake'
    spec.add_development_dependency 'rspec'
    spec.add_development_dependency 'rspec-html-matchers'
    spec.add_development_dependency 'rubocop'

    spec.add_dependency 'actionview'
    spec.add_dependency 'activesupport'
    spec.add_dependency 'hashie', '~> 3.0'
end
