require './ticket_viewer.rb'
require 'rack/test'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "https://dematteo.zendesk.com/api/v2/tickets.json").with(basic_auth: ['robertdematteo@hotmail.com', 'rob71ertd']).
      to_return(status: 200, body: "stubbed response", headers: {})
  end
end


set :environment, :test

def app
  Sinatra::Application
end

describe 'Load ticket Page' do
  include Rack::Test::Methods

  it "Clicking on first page should load the first 25 tickets page" do 
    get '/tickets?page=1'
    expect(last_response.status).to eq 200
  end

  it "Clicking on indiviual ticket link should load the individual ticket page" do 
    get '/tickets/1'
    expect(last_response.status).to eq 302
  end

end


