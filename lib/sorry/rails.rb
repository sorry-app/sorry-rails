require 'sorry/rails/configuration'
require 'sorry/rails/script_tag_helper'
require 'sorry/rails/subscriber_serializer'
require 'sorry/rails/railtie' if defined?(Rails::Railtie)
require 'sorry/rails/version'

module Sorry
    module Rails

        # Define the JS plugin version to be used
        # by the script tag generator.
        PLUGIN_VERSION = '4.latest'.freeze

        class << self
            # Attr to store the configuration.
            attr_accessor :configuration
       
            # Allow configuration by block.
            def configure
                # Singleton the config instance.
                self.configuration ||= Configuration.new
                
                # Yield the config block.
                yield(configuration)

                # Return the config.
                self.configuration
            end
        end

    end
end
