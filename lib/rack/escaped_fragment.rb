require "rack/escaped_fragment/version"
require "rack"
require "uri"

module Rack
  class EscapedFragment
    def initialize(app)
      @app = app
    end

    def call(env)
      req = ::Rack::Request.new(env)

      if env['ESCAPED_FRAGMENT'] = req.params['_escaped_fragment_']
        req.params.delete '_escaped_fragment_'
        env['QUERY_STRING'] = Rack::Utils.build_query req.params
      end

      @app.call(env)
    end
  end

  class Request
    def escaped_fragment
      @env["ESCAPED_FRAGMENT"]
    end

    def escaped_fragment?
      !!escaped_fragment
    end
  end
end
