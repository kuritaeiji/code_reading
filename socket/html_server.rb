require('socket')

server = TCPServer.open(3000)

def html_file
  File.open('socket/index.html', 'r') { |f| f.read }
end

while true
  Thread.new(server.accept) do |socket|
    request = socket.gets

    puts(request)

    if request.include?('GET')
      socket.write <<-RES
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Connection: closed

#{html_file}
      RES
    end

    socket.close
  end
end

server.close