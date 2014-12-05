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

post '/form-submit' do

  @form_details = Hash.new()
  @form_details['forename'] = params[:forename]
  @form_details['surname'] = params[:surname]
  @form_details['house_number'] = params[:house_number]
  @form_details['street'] = params[:street]
  @form_details['city'] = params[:city]
  @form_details['postcode'] = params[:postcode]
  @form_details['sex'] = params[:sex]
  @form_details['interest'] = Hash.new()
  @form_details['interest']['walking'] = params[:walking]
  @form_details['interest']['cycling'] = params[:cycling]
  @form_details['interest']['swimming'] = params[:swimming]
  @form_details['cars'] = params[:cars]
  erb :form_output
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
  erb :menu
end

get '/form-details' do
  erb :form
end
