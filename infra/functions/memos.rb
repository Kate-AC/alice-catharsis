require 'json'
require 'aws-sdk'

def get_client
  Aws::DynamoDB::Client.new
end

def index(event:, context:)
  tag_id = event["queryStringParameters"]["tag_id"] unless event["queryStringParameters"].nil?
  tag_id = nil if tag_id == ""

  results = get_client.scan(table_name: "memos")
  memos = results.items.filter { |memo| memo["deleted"] == false }
  memos = memos.sort { |a, b| b["id"] <=> a["id"] }
  memos = memos.filter { |memo| memo["tag_id"] == tag_id.to_s } unless tag_id.nil?

  memos.map do |memo|
    result = get_client.get_item(table_name: "tags", key: {id: memo["tag_id"]})
    memo["tag_name"] = result.item["name"]
    memo["tag_color"] = result.item["color"]
  end

  {
    statusCode: 200,
    body: JSON.generate(memos),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

def show(event:, context:)
  memo_id = event["queryStringParameters"]["memo_id"]

  result = get_client.get_item(table_name: "memos", key: {id: memo_id.to_s})
  memo = result.item

  raise StandardError.new "Memo-id is not found." if memo["deleted"]

  result = get_client.get_item(table_name: "tags", key: {id: memo["tag_id"]})
  tag = result.item

  {
    statusCode: 200,
    body: JSON.generate({memo: memo, tag: tag}),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end
