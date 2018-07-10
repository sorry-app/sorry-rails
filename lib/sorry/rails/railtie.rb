module Sorry
    module Rails
        class Railtie < Rails::Railtie

            # On initialization.
            initializer "sorry-rails" do
                # Action view helpers.
                ActiveSupport.on_load :action_view do
                    # Include the script tag helper.
                    include Sorry::Rails::ScriptTagHelper
                end
            end

        end
    end
end
