require 'sinatra'
require 'sinatra/json'
require 'http'
require 'dotenv'
Dotenv.load

set :show_exceptions, :after_handler



def getTicket
  url = 'https://dematteo.zendesk.com/api/v2/tickets.json'
  begin
    data = HTTP.basic_auth(:user => ENV["USERNAME"], :pass => ENV["PASSWORD"])
  .get(url).to_s
  return data1 = JSON.parse(data)
  rescue => exception
    return 403, "Somethin"
  end

  error 403 do
    "Access forbidden"
    erb :oops
  end

end


get '/tickets' do
  data1 = getTicket()
  @data2 = data1['tickets'] 
  erb :index
end

get '/tickets/:id' do
  data1 = getTicket()
  data3 = data1['tickets']
  id = params['id'].to_i
  @found_ticket = data3.find {|task| id == task['id'] }

  erb :show
end

