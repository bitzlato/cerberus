module RequestHelper
  def json_response
    JSON.parse(last_response.body) rescue {}
  end


end