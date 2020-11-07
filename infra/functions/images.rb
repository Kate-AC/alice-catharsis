require 'json'

def index(event:, context:)
    { statusCode: 200, body: JSON.generate('999Hello from Lambda!') }
end

def hoge(event:, context:)
    { statusCode: 200, body: JSON.generate('hogehogehoge') }
end

