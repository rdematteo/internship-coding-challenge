require './ticket_viewer_fake.rb'
require 'rack/test'
require 'webmock/rspec'

set :environment, :test

def app
  Sinatra::Application
end


describe 'Fake ticket data' do
  it 'id should be an integer' do
    data = File.open(File.dirname(__FILE__)  + '/fake_data.json').read
    response = JSON.load(data)
    expect(response.first['id']).to be_an_instance_of(Integer)
  end

  it 'descritpion shoud be a string' do
    data = File.open(File.dirname(__FILE__)  + '/fake_data.json').read
    response = JSON.load(data)
    expect(response.first['description']).to be_an_instance_of(String)
  end

  it 'description shoud not be empty' do
    data = File.open(File.dirname(__FILE__)  + '/fake_data.json').read
    response = JSON.load(data)
    expect(response.first['description']).not_to be_empty
  end

  it 'url to match ' do
    data = File.open(File.dirname(__FILE__)  + '/fake_data.json').read
    response = JSON.load(data)
    expect(response.first['url']).to match("https://dematteo.zendesk.com/api/v2/")
  end


end