require 'json'
require 'aws-sdk'

def get_client
  Aws::DynamoDB::Client.new
end

def index(event:, context:)
  types = { "normal" => "0", "r18" => "1" }.freeze

  target_type_string = event["queryStringParameters"]["target_type"]
  target_type = types[target_type_string]

  results = get_client.scan(table_name: "images")
  images = results.items.filter { |image| image["deleted"] == false }
  images = images.sort { |a, b| b["id"] <=> a["id"] }

  images = images.filter { |image| image["target_type"] == target_type } unless target_type.nil?

  {
    statusCode: 200,
    body: JSON.generate(images),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

