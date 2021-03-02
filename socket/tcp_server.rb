require('socket')

server = TCPServer.open(3000)

while true
  # クライアントから要求が届いたらソケットを生成
  socket = server.accept # TCPSocketのインスタンス
  puts('socket start')

  # クライアントから送られたデータをソケットから読み出す
  while buffer = socket.gets
    puts(buffer)
    # レスポンスを返す
    socket.write('200')
  end

  # 通信が終了するとsocketを破棄
  socket.close
  puts('socket close')
end

server.close