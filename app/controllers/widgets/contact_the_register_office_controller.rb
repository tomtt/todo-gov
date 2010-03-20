require "open-uri"
require "ostruct"

class Widgets::ContactTheRegisterOfficeController < Widgets::WidgetsController
  def create
    api_response = JSON.parse(open("http://tartarus.org/richard/registries/find?loc=#{CGI.escape(params[:user_data][:postcode])}").read)
    @registry_offices = api_response["registries"].map{|v| OpenStruct.new(v)}
  end
end
