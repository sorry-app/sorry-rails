require 'hashie/dash'

module Sorry
    module Rails
        class Configuration < Hashie::Dash

            # Define the properties in the config hash.
            property :page_id
            # Current user method, defaults to Devise compatible.
            property :current_user_method, default: :current_user

            # Property accessors for the subscriber.
            property :email_method, default: :email
            property :component_ids_method, default: :component_ids

        end
    end
end
