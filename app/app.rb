require 'sinatra'
require 'plivo'
require 'better_errors'


base_url = 'http://localhost/'
AUTH_ID = "IDMANWZIZJAXNJRHZJAZYJ"
AUTH_TOKEN = "MzMxNjZmYWFmOWQ3MThhZDg4ZjZmMTU5NzA1YmY5"

class HelloWorldApp < Sinatra::Base
get '/dial' do
  to_number = params[:To]
  from_number = params[:CLID] ? params[:CLID] : params[:From] ? params[:From] : ''
  caller_name = params[:CallerName] ? params[:CallerName] : ''

  resp = Response.new()
  if not to_number
    resp.addHangup()
  else
    if to_number[0, 4] == "sip:"
      d = resp.addDial({'callerName' => caller_name})
      d.addUser(to_number)
    else
      d = resp.addDial({'callerId' => from_number})
      d.addNumber(to_number)
    end
  end
  content_type :xml 
  "text/xml"


d = resp.addGetDigits({'action' => "http://whatever.com", 'method' => 'POST', 'numDigits' => '1')
d.addSpeak("herllo dude")
resp.to_xml()
end
end
