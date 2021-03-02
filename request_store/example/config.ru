require_relative('../lib/request_store.rb')
require('securerandom')

class RackApp
  def call(env)
    RequestStore.store[:foo] = 'foo'
    [200, { 'content-type' => 'text/plain' }, [RequestStore.store[:foo]]]
  end
end

use(RequestStore::Middleware)
run(RackApp.new)