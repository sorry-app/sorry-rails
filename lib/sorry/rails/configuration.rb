# frozen_string_literal: true

require 'hashie/dash'

module Sorry
    module Rails
        #
        # Configuration class is a glorified hash
        # for storing settings to be used by the plugin.
        #
        class Configuration < Hashie::Dash

            # Define the properties in the config hash.
            property :page_id
            # Current user method, defaults to Devise compatible.
            property :current_user_method, default: :current_user

            # Property accessors for the subscriber.
            property :email_method, default: :email
            property :component_ids_method, default: :component_ids

        end
    end
end
