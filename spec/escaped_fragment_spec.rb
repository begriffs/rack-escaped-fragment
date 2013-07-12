require 'rack/escaped_fragment'

describe Rack::EscapedFragment do
  let(:app) { lambda { |env| [200, {}, []] } }
  let(:middleware) { Rack::EscapedFragment.new(app) }
  let(:mock_request) { Rack::MockRequest.new(middleware) }

  before :each do
    app.stub(:call).and_call_original
  end

  it "does not modify a request with no query parameters" do
    app.should_receive(:call).with(hash_including('PATH_INFO' => '/'))
    mock_request.get '/'
  end

  it "does not modify a request with query params except _escaped_fragment_" do
    app.should_receive(:call).with(hash_including('PATH_INFO' => '/foo', 'QUERY_STRING' => 'q1=a1&q2=a2'))
    mock_request.get '/foo?q1=a1&q2=a2'
  end

  context "with both a query and _escaped_fragment_ provided" do
    it "preserves the query and translates the escaped fragment" do
      app.should_receive(:call).with(
        hash_including('ESCAPED_FRAGMENT' => 'key=value', 'QUERY_STRING' => 'query')
      )
      mock_request.get 'www.example.com/page?query&_escaped_fragment_=key=value'
    end
  end

  context "with an _escaped_fragment_ which has urlencoded characters" do
    it "decodes the characters" do
      app.should_receive(:call).with(
        hash_including('ESCAPED_FRAGMENT' => 'foo bar')
      )
      mock_request.get '/?_escaped_fragment_=foo%20bar'
    end
  end
end
