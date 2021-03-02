class MyHeader
  def initialize(bodies)
    @bodies = bodies
  end

  def each
    yield('content-type', 'text/plain')
    yield('content-length', @bodies.join.bytesize.to_s)
  end
end

class MyBody
  def initialize(bodies)
    @bodies = bodies
  end

  def each
    for body in @bodies
      yield(body)
    end
  end
end

rack_app = ->(env) {
  bodies = ["Hello, Rack!\n", "hello, world"]
  [200, MyHeader.new(bodies), MyBody.new(bodies)]
}

run(rack_app)