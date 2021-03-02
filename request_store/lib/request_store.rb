require_relative('./request_store/middleware.rb')

module RequestStore
  class << self
    # 現在のスレッドのrequest_storeハッシュを返し、処理を移譲する 
    # RequestStore.store[:foo] = 0のように使う
    def store
      Thread.current[:request_store] ||= {}
    end

    # 一連のリクエスト、レスポンス処理が終わるとクリアする
    def clear!
      Thread.current[:request_store] = {}
    end
  end
end