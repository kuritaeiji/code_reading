require('pp')

class RackApp
  def call(env)
    pp(env)

    [200, {}, []]
  end
end

run(RackApp.new)