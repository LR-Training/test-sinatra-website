require 'sinatra'
require 'erb'
require 'pg'
require 'json'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/login' do

  conn = PGconn.connect("localhost", 5432, '', '', "test", "postgres", "admin")
  res  = conn.exec('SELECT * from "users" where user_name = \'' + params[:username] + '\' and user_password= \'' + params[:password] + '\' ')

  if res.count > 0 then
    puts res[0]['user_status']
    if (res[0]['user_status'] == 1)
      redirect '/blocked'
    else
      redirect '/menu'
    end
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

get '/get_user/:user_id' do
  conn = PGconn.connect("localhost", 5432, '', '', "test", "postgres", "admin")
  res  = conn.exec('SELECT * from "users" where user_id = \'' + params['user_id'] + '\' ')

  result = {}
  if res.count > 0 then
    result['user_name'] = res[0]['user_name']
    result['user_id'] = res[0]['user_id']
    result['user_status'] = res[0]['user_status']
  else
    result['status'] = 'No User'
  end
  return result.to_json
end

post '/add_user' do

  conn = PGconn.connect("localhost", 5432, '', '', "test", "postgres", "admin")
  res  = conn.exec('SELECT * from "users" where user_name = \'' + params['user_name'] + '\' ')

  result = {}
  if res.count > 0 then
    result['status'] = 'User Already Exists'
  else
    conn = PGconn.connect("localhost", 5432, '', '', "test", "postgres", "admin")
    res  = conn.exec('insert into users (user_name, user_password) Values (\'' + params['user_name'] + '\', \'' + params['user_password'] + '\')  ')

    result['status'] = 'User Added'
  end

  return result.to_json
end
