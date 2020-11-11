require 'json'
require 'aws-sdk'

def get_client
  Aws::DynamoDB::Client.new
end

def index(event:, context:)
  types = { "0" => "normal", "1" => "r18" }.freeze

  target_type_string = event["queryStringParameters"]["target_type"]

  results = get_client.scan(table_name: "images")
  images = results.items.filter { |image| image["deleted"] == false }
  images = images.sort { |a, b| b["sort_id"] <=> a["sort_id"] }
  images.each { |image| image["target_type"] = types[image["target_type"]] }

  images = images.filter { |image| image["target_type"] == target_type_string } if target_type_string != "all"

  {
    statusCode: 200,
    body: JSON.generate(images),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

