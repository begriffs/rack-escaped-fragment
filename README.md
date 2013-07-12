# Rack::EscapedFragment

Rack middleware to help make your AJAX application crawlable. If
your app uses hashbangs in its routes (like `/page#!section_one`)
then Google, when it crawls your site, will escape the hash fragment
into a query parameter so your server can see it and respond with
a static version of the page. For more details see [Google's
Guide](https://developers.google.com/webmasters/ajax-crawling/docs/getting-started)

This gem detects the presence of an escaped fragment in the request
and makes it easy for the back-end to distinguish it and route to a
static page controller.

## Usage in Rails

Include the gem in your Gemfile

    gem 'rack-escaped-fragment'

Include the middleware in your app

    # in config/application.rb
    config.middleware.use 'Rack::EscapedFragment'

Use the extra info provided by the middleware to update your routes.
This example assumes you have a fancy ajaxed page at `/fancy_page`
and want to create static pages with a controller called
`static_generator`.

    # in config/routes.rb
    get '/fancy_page', to: 'static_generator#generate', constraints: { escaped_fragment?: true }

You can access the urldecoded value of the escaped fragment in your controller like this

    # In controller
    fragment = request.escaped_fragment

## Alternatives

You could also avoid using hash bangs and use [pushstate](http://www.seroundtable.com/google-ajax-pushstate-vs-hashbang-16464.html) instead. Then
make your app send static content at any url if it detects a non-javascript
enabled user agent, like the Google bot. That's the modern way.
