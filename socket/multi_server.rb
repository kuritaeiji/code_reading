require('socket')
require('pry-byebug')

server = TCPServer.open(3000)

while true
  Thread.new(server.accept) do |socket|
    puts(socket.peeraddr)

    while buffer = socket.gets
      puts(buffer)
      socket.write('200')
    end

    socket.close
  end
end

server.close