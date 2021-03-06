# frozen_string_literal: true

require 'bundler/setup'
require 'faker'
require 'sorry/rails'
require 'rspec-html-matchers'

RSpec.configure do |config|
    # Enable flags like --only-failures and --next-failure
    config.example_status_persistence_file_path = '.rspec_status'

    # Disable RSpec exposing methods globally on `Module` and `main`
    config.disable_monkey_patching!

    config.expect_with :rspec do |c|
        # Use more modern syntax.
        c.syntax = :expect
    end

    # Reset config singleton after each test.
    config.around(:each) do |example|
        # Create a default plugin config.
        Sorry::Rails.configuration ||= Sorry::Rails::Configuration.new

        # Run the examples.
        example.run

        # Remove the config.
        Sorry::Rails.configuration = nil
    end

    # Include have_tag matchers.
    config.include RSpecHtmlMatchers
end
