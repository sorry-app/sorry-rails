# Sorry™ - Rails

> A Rails gem to add the [Sorry™ Website Plugin](https://github.com/sorry-app/status-bar) to your application. Easily display notices from your status page to your users, and register them as subscribers to receive updates when the particular parts of your application they use are experiencing issues.

## Installation

#### Install the Gem

Add the gem to your Gemfile.

```ruby
gem 'sorry-rails'
```

Once this has been done you can run `bundle install` to install the gem into your bundle.

#### Create an Initializer

Create an initializer to configure your plugin, we'd suggest putting this in `/config/initializers/sorry-rails.rb`.

```ruby
# Configure website plugin.
Sorry::Rails.configure do |config|
    # Set the page identity.
    config.page_id = 'xxxxxxxx'
end
```

Place your own status page ID into the initializer, so the plugin knows where to pull your updates from.

#### Include the JavaScript

You can now use the helper method to include the appropriate JavaScript into your layouts and views.

```erb
<!-- Plugin to install status notices. -->
<%= sorry_script_tag %>
```

You'll most likely want to add this to `application.html.erb` so it displays on all pages.

## Subscriber Data

By default the plugin plays nicely with [Devise](https://github.com/plataformatec/devise) by looking for a method called `current_user`, if this method returns an object with an `email` attribute they are passed along as a subscriber, so they'll appear in your subscribers list.

### Custom current user method

If you don't use Devise, or it's default `current_user` method, you can customize the method name in your initializer.

```ruby
config.current_user_method = :logged_in_user
```

Pass a symbol which represents the method name, and we'll call that.

### Subscribing to specific components (Established plan only)

Sometimes users don't utilize all of your application, and they'll only want updates about incidents which affect the parts they actually use. For example, if one of our customers uses our Mailgun integration, but Sendgrid is currently experiencing issues, they don't need to know.

You can pass us an array of component_ids that the subscriber is interested in.

```ruby
# Method name example.
config.component_ids_method = :component_ids

# Proc based example.
config.component_ids_method = Proc.new { |user| 
    # Logic here to get array of IDs...
}
```

As per the example, this can either be a method_name to be called on your current_user, or a Proc which is passed the current user, both should return an array of numeric component ids.

## Contributing

In lieu of a formal style-guide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code.

Once you are happy that your contribution is ready for production please send us a pull request, at which point we'll review the code and merge it in.

## Versioning

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, This project will be maintained under the Semantic Versioning guidelines as much as possible.

Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit <http://semver.org/>.

## Authors & Contributors

**Robert Rawlins**

+ <http://twitter.com/sirrawlins>
+ <https://github.com/SirRawlins>

## Copyright

&copy; Copyright - See [LICENSE](LICENSE.txt) for details.
