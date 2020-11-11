require 'json'
require 'aws-sdk'

MAX_LIMIT = 5

def get_client
  Aws::DynamoDB::Client.new
end

def latest(event:, context:)
  types = { "0" => "normal", "1" => "r18" }.freeze

  params = event["queryStringParameters"]

  target_type_string = params.nil? ? "all" : params["target_type"] ||= "all"
  limit = params.nil? ? MAX_LIMIT : params["limit"].to_i ||= MAX_LIMIT

  raise StandardError.new if limit > MAX_LIMIT

  results = get_client.scan(table_name: "images")
  images = results.items.filter { |image| image["deleted"] == false }
  images = images.sort { |a, b| b["sort_id"] <=> a["sort_id"] }
  images.each { |image| image["target_type"] = types[image["target_type"]] }

  images = images.filter { |image| image["target_type"] == target_type_string } if target_type_string != "all"

  responseImages = images.map do |image|
    {
      id: image["id"],
      title: image["title"],
      url: image["url"],
      thumbnail: image["thumbnail"],
      target_type: image["target_type"]
    }
  end

  {
    statusCode: 200,
    body: JSON.generate(responseImages.slice(0, limit)),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

