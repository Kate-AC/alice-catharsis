require 'json'
require 'aws-sdk'

def get_client
  Aws::DynamoDB::Client.new
end

def index(event:, context:)
  results = get_client.scan(table_name: "tags")
  tags = results.items

  {
    statusCode: 200,
    body: JSON.generate(tags),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

