#######
# Function: rest_get_call
# Description: This function should be used to do all get requests
# Inputs:
#     - url = The url that the web service is calling
# Outputs:
#     - curl response
######
def rest_get_call(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)

  return response
end

#######
# Function: rest_post_call
# Description: This function should be used to do all post requests
# Inputs:
#     - url = The url that the web service is calling
#     - data = The data post for the post
#     - body = The body for the post
# Outputs:
#     - curl response
######
def rest_post_call(url, data = nil, body = nil)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  request.basic_auth $http_auth_name, $http_auth_password

  if (!data.nil?) then
    request.set_form_data(data)
  end

  if (!body.nil?) then
    request.body = body
  end

  response = http.request(request)

  return response
end
