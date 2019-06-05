require 'sinatra'
# require 'sinatra/json'
require 'http'

get '/' do
  
  url = 'https://dematteo.zendesk.com/api/v2/tickets.json'
  
  data = HTTP.basic_auth(:user => "robertdematteo@hotmail.com", :pass => "rob71ertd")
  .get(url).to_s
  data1 = JSON.parse(data)
  @data2 = data1['tickets']


  

  

  erb :test
end

# data = HTTP.get(url).to_s
# data_json = JSON.parse(data)