# Sorry™ - Rails

> A Rails gem to add the [Sorry™](https://www.sorryapp.com/) website plugin to your application. Easily display notices from your status page to your users, and register them as subscribers to receive updates when the particular parts of your application they use are experiencing issues.

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

&copy; Copyright - See [LICENSE](LICENSE) for details.
