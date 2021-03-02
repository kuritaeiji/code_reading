require('rack')

module RequestStore
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      response = @app.call(env)

      body = response.pop
      # アプリケーションサーバーの直前でThread.current[:request_store]を{}に初期化する
      # Rack::BodyProxyはcloseメソッドを持つオブジェクトをbodyに渡すとcloseメソッドを最後に実行してくれることを利用している（closeメソッドの中でブロックを実行する）
      body_proxy = Rack::BodyProxy.new(body) do
        RequestStore.clear!
      end
      response.push(body_proxy)
    end
  end
end