require 'sinatra'
require 'erb'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/login' do
  if ((params[:username] == 'user@example.org') && (params[:password] = 'password'))
    redirect '/menu'
  elsif (params[:username] == 'blocked@example.org')
    redirect '/blocked'
  else
    redirect '/unknown'
  end
end

get '/unknown' do
  @message = 'Unknown User'
  erb :message
end

get '/blocked' do
  @message = 'User Blocked'
  erb :message
end

get '/menu' do
  @message = 'Logged in'
  erb :message
end
