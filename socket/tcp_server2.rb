require('socket')
require('pry-byebug')

server = TCPServer.open(3000)

while true # 接続待ち
  servers = IO.select([server]) # 入力を受け付けるioオブジェクトが複数の時の使う 例）ipv4tcp_server, ipv6tcp_serverを動かす時
  if srv = servers[0][0]
    socket = srv.accept
    puts('socket start')

    # クライアントから送られたデータをソケットから読み出す
    while buffer = socket.gets # 接続が切れるまで
      puts(buffer)
      # レスポンスを返す
      socket.write('200')
    end

    # 通信が終了するとsocketを破棄
    socket.close
    puts('socket close')
  end
end