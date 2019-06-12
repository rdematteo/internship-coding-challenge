require './ticket_viewer.rb'
require 'rack/test'
require 'webmock/rspec'


set :environment, :test

def app
  Sinatra::Application
end

WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.before(:each) do
  stub_request(:get, "https://dematteo.zendesk.com/api/v2/tickets.json").
  with(
    headers: {
  'Accept'=>'*/*',
  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  'Host'=>'dematteo.zendesk.com',
  'User-Agent'=>'SOME 200 STRING'
    }).
  to_return(status: 200, body: "stubbed response1", headers: {})
  end
end

describe 'External request via stub' do
before do 
  response = "stubbed response"
  stub_request(:any, "https://dematteo.zendesk.com/api/v2/tickets.json").to_return(:body => response, :status => 200, :headers => {})
end
  it 'queries Zendesk' do
    uri = URI('https://dematteo.zendesk.com/api/v2/tickets.json')
    response1 = Net::HTTP.get(uri)
    expect(response1).to eq "stubbed response"
  end
end


describe 'Load tickets page' do
  include Rack::Test::Methods
  before do 
    stub_request(:any, 'https://dematteo.zendesk.com/api/v2/tickets.json').to_return( :status => [200, "Good"])
  end
  it "Clicking on first page should return 404" do 
    get "https://dematteo.zendesk.com/api/v2/tickets.json"
    expect(last_response.status).to eq 404
  end
end




  