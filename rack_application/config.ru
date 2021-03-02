class HelloRackApp
  def call(env)
    [200, { 'content-type' => 'text-plain' }, ['Hello, Rack!']]
  end
end

run(HelloRackApp.new)

# Rackアプリはobjectでありcallメソッドに応答すること この場合はHelloRackAppのインスタンスがRackアプリ
# callメソッドはenv引数を持つ
# callメソッドはステータスコード、レスポンスヘッダー、レスポンスボディーの配列を返す
# レスポンスヘッダーはenumarableで、key/valueを持ち、keyもvalueもStringオブジェクトであること
# レスポンスボディーはenumarableで、それぞれの値がStringオブジェクトであること