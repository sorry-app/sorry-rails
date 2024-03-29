# frozen_string_literal: true

require 'active_support/all'
require 'action_view'

module Sorry
    module Rails
        #
        # An ActionView helper which generates the JavaScript
        # includes required for the plugin to work.
        #
        module ScriptTagHelper

            # Base rails helpers we utilize.
            include ActionView::Context
            include ActionView::Helpers::AssetTagHelper
            include ActionView::Helpers::JavaScriptHelper

            #
            # Generate the Sorry Website Plugin script
            # tag to display status notices to the user
            # and register them as a subscriber.
            #
            def sorry_script_tag(options = {})
                # Include the payload tag and the include
                # tags for the plugin.
                safe_join(
                    [
                        sorry_script_payload_tag(options),
                        sorry_script_include_tag(options)
                    ]
                )
            end

            def sorry_script_include_tag(options)
                # Pull the target page from the options, default to config.
                page_id = options.fetch(
                    'page_id',
                    Sorry::Rails.configuration['page_id']
                )
                # Merge in default options for the 'script' tag.
                options.reverse_merge!(
                    async: true,
                    data: {
                        for: page_id
                    }
                )

                # Build the JavaScript tag for the plugin include.
                # Use the latest JS version defined in the plugin.
                javascript_include_tag(
                    "https://code.sorryapp.com/status-bar/#{Sorry::Rails::PLUGIN_VERSION}/status-bar.min.js",
                    options
                )
            end

            def sorry_script_payload_tag(options)
                # Get the method name from options, default to config.
                current_user_method = options.fetch(
                    'current_user_method',
                    Sorry::Rails.configuration['current_user_method']
                )

                # See if the current user is signed in, so we can
                # include them as a subscriber.
                if respond_to?(current_user_method) && send(current_user_method).present?
                    # Get the current user.
                    current_request_user = send(current_user_method)

                    # Serialize the user into a subscriber payload.
                    subscriber_payload = SubscriberSerializer.new(current_request_user).to_json

                    # We have a user method, let's include the JS payload
                    # object for them as a subscriber.
                    javascript_tag options.merge(id: 'sorry-subscriber-data') do
                        # Include the subscriber payload on the window.
                        "window.SorryAPIOptions = { \"subscriber\": #{subscriber_payload} };".html_safe
                    end
                end
            end

        end
    end
end
