require 'json'

module Sorry
    module Rails
        #
        # Serializer class takes the applications current_user
        # and converts it into a safe JSON payload to be included
        # in the plugin and sent to Sorry as a subscriber.
        #
        class SubscriberSerializer

            # Define serializeable fields.
            SERIALIZEABLE_ATTRIBUTES = [:email, :component_ids].freeze

            #
            # Decorator which receives the current user
            # model and safely converts them into JSON
            # for adding to the payload.
            #

            def initialize(current_user)
                # Set user instance.
                @current_user = current_user
            end

            def to_json(serializeable_attributes = SERIALIZEABLE_ATTRIBUTES)
                # Check the serializeable attributes are allowed.
                serializeable_attributes!(serializeable_attributes)

                # Start with an empty attributes hash
                attributes = {}

                # Loop over the collection or attributes
                # we can serialize.
                serializeable_attributes.each do |attribute|
                    # Add this attribute to the hash.
                    attributes[attribute] = attribute_value(attribute)
                end

                # Serialize the collection
                # remove any attributes not serialized.
                attributes.compact.to_json
            end

            #
            # The value of the attribute can come
            # from a proc, or from a custom field, or
            # by looking for a direct attribute on the user.
            #
            def attribute_value(attribute)
                # Get the configured method for the attribute.
                attribute_method = Sorry::Rails.configuration.fetch("#{attribute}_method")

                # See if the method is a proc.
                if attribute_method.respond_to?(:call)
                    # It's a proc, call it with the model.
                    attribute_method.call(@current_user)
                # See if the instance responds to it.
                elsif @current_user.respond_to?(attribute_method)
                    # It's a method name, invoke
                    # the method on the model.
                    @current_user.public_send(attribute_method)
                end
            end

            #
            # Check attributes are serializeable and throw an exception
            # if they're not included in SERIALIZEABLE_ATTRIBUTES
            #
            def serializeable_attributes!(serializeable_attributes)
                # See if the attributes are serializeable.
                unless serializeable_attributes?(serializeable_attributes)
                    # They're not, so throw an error.
                    raise UnserializableAttributeError, "The attributes (#{(serializeable_attributes - SERIALIZEABLE_ATTRIBUTES)}) are not included in the approved list."
                end
            end

            #
            # Determine if a collection of attribute names
            # can be serialized or not.
            #
            def serializeable_attributes?(serializeable_attributes)
                # Check that all appear in SERIALIZEABLE_ATTRIBUTES
                (serializeable_attributes - SERIALIZEABLE_ATTRIBUTES).empty?
            end

            # Custom error for when someone asks to serialize an
            # attribute not listed in SERIALIZEABLE_ATTRIBUTES.
            class UnserializableAttributeError < StandardError; end

        end
    end
end
