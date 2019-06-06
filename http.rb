require 'sinatra'
require 'sinatra/json'
require 'http'
require 'dotenv'
Dotenv.load

set :show_exceptions, :after_handler


def getTicket
 begin
   url = 'https://dematteo.zendesk.com/api/v2/tickets.json'
    data = HTTP.basic_auth(:user => ENV["USERNAME"], :pass => ENV["PASSWORD"])
  .get(url).to_s
  return data1 = JSON.parse(data)
 
rescue
  p 'api down, no internet'
  
 end 
  
end



get '/' do

  erb :landing
end


get '/tickets' do

page = params["page"].to_i

@result = []
data1hash = getTicket()
data2array = data1hash['tickets'] 
data2array.each_slice(25) do |ticket|
  @result << ticket
end
@result = @result[page]

  erb :index
end

get '/tickets/:id' do
  data1 = getTicket()
  data3 = data1['tickets']
  id = params['id'].to_i
  @found_ticket = data3.find {|ticket| id == ticket['id'] }

  erb :show
end

