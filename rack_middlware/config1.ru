class RackApp
  def call(env)
    [200, { 'content-type' => 'text/plain' }, ['Hello, I am Rack Endpoint']]
  end
end

class AnotherRackMiddleware
  def initialize(app)
    @app = app # RackApp
  end

  def call(env)
    # エンドポイントからレスポンスを受け取る
    status, headers, body = @app.call(env)
    # エンドポイントからのレスポンスを加工する
    fixed_body = body.unshift("Hello, I am Another RackMiddleware\n")
    # 加工したレスポンスを返す
    [status, headers, fixed_body]
  end
end

class RackMiddleware
  def initialize(app)
    @app = app # AnotherRackMiddleware
  end

  def call(env)
    status, headers, body = @app.call(env)
    fixed_body = body.unshift("Hello, I am Rack Middleware\n")
    [status, headers, fixed_body]
  end
end

use(RackMiddleware)
use(AnotherRackMiddleware)
run(RackApp.new)