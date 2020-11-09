require 'net/http'
require 'uri'
require 'json'
require 'aws-sdk-ssm'

def get_ssm_client
  Aws::SSM::Client.new
end

def mail(event:, context:)
  response = get_ssm_client.get_parameter({
    name: "/lambda/webhook_url",
    with_decryption: true
  })

  uri = URI.parse(response[:parameter][:value])
  body = JSON.parse(event["body"])

  params = {
    username: "Alice-Cathersis contact form",
    icon_emoji: ":alien:",
    channel: "#rappy-notify",
    text: body["message"]
  }

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  http.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    http.request(request)
  end

  {
    statusCode: 200,
    body: JSON.generate({}),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    }
  }
end

