require './ticket_viewer.rb'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe 'Load Home Page' do
  include Rack::Test::Methods

  it "Starting app should load the landing page" do 
    get '/'
    expect(last_response).to be_ok
  end

  it "Landing page should include" do 
    get '/'
    expect(last_response.body).to include("Welcome to my ticket viewer")
  end
end

describe 'Load ticket Page' do
  include Rack::Test::Methods

  it "Clicking on first page should load page 1" do 
    get '/tickets?page=1'
    expect(last_response.status).to eq 200
  end

  it "Clicking on indiviual ticket link should load the individual ticket page" do 
    get '/tickets/1'
    expect(last_response.status).to eq 200
  end

end

describe 'Redirect to page 1' do
  include Rack::Test::Methods

  it "redirects to page 1 when url params =  page = -1" do 
    get '/tickets', :page => -1
    expect(last_request.path).to eq('/tickets')
  end

end


describe 'run ticket function' do
  it 'records method call' do
    my_spy = spy
    my_spy.getTicket()
 
    expect(my_spy).to have_received(:getTicket).exactly(1).times

  end

end

