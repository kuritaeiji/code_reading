require('pry-byebug')
require('webrick')

surver = WEBrick::HTTPServer.new({
  DocumentRoot: './',
  BindAddress: '127.0.0.1',
  Port: '3000'
})
surver.mount('/', WEBrick::HTTPServlet::FileHandler, 'index.html')
surver.mount('/cgi', WEBrick::HTTPServlet::CGIHandler, 'cgi.rb')
surver.start