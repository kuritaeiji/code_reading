class RackApp
  def call(env)
    file = File.open('./a.jpg', 'r')

    [200, { 'content-type' => 'image/jpg' }, file]
  end
end

run(RackApp.new)