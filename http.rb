require 'sinatra'
require 'sinatra/json'
require 'http'

url = 'https://dematteo.zendesk.com/api/v2/tickets.json'
data = HTTP.basic_auth(:user => "robertdematteo@hotmail.com", :pass => "rob71ertd")
.get(url).to_s
data1 = JSON.parse(data)


get '/tickets' do
  @data2 = data1['tickets'] 
  erb :index
end

get '/tickets/:id' do
  data3 = data1['tickets']
  id = params['id'].to_i
  found_ticket = data3.find {|task| id == task['id'] }
  return json(found_ticket)


erb :indivdual
end

