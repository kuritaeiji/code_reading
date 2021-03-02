require('socket')

begin
  socket = TCPSocket.open('127.0.0.1', 3000)
  socket.write('Hello, Tcp Server')
  puts(socket.gets)
ensure
  socket.close if socket
end