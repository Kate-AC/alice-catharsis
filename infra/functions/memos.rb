require 'json'

def index(event:, context:)
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

