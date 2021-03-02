class RackApp
  def call(env)
    file = File.open('a.jpg', 'r')
    image_str = File.read(file)

    [200, { 'content-type' => 'image/jpg' }, [image_str]]
  end
end

run(RackApp.new)