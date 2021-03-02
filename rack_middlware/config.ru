class RackApp
  def call(env)
    [200, { 'content-type' => 'text/plain' }, ["Hello, RackApp\n", 'Hello, World']]
  end
end

class RackMiddleware
  def initialize(app)
    @app = app # RackAppインスタンス
  end

  def call(env)
    status, headers, body = @app.call(env)
    byte_size = body.sum(0) { |b| b.bytesize }.to_s
    fixed_body = headers.merge('content-length' => byte_size)

    [status, headers, body]
  end
end

use(RackMiddleware)
run(RackApp.new)