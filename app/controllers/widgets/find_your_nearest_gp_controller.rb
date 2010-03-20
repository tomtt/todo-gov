require "open-uri"
require "ostruct"

class Widgets::FindYourNearestGpController < Widgets::WidgetsController
  def create
    @doctors = JSON.parse(open("http://teeth.tomlea.co.uk/doctors/search?postcode=#{CGI.escape(params[:user_data][:postcode])}").read).map{|v| OpenStruct.new(v)}
  end
end
