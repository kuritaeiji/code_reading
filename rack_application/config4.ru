class RackApp
  def call(env)
    path = env['PATH_INFO']

    if path == '/hello'
      [200, { 'content-type' => 'text/plain' }, ['hello']]
    else
      [404, { 'content-type' => 'text/plain' }, ['404 not found']]
    end
  end
end

run(RackApp.new)