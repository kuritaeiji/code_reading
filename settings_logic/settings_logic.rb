require('yaml')
require('pry-byebug')

class SettingsLogic
  class << self
    # selfはSetting
    def source(yaml_file = nil) # setterでもありgetterでもある
      @source ||= yaml_file
    end

    def namespace(env = nil)
      @nampespace ||= env
    end

    def method_missing(name, *args)
      instance.send(name, *args)
    end

    private
      def instance
        return @instance if @instance
        @instance = new
        create_accessors # 初回以外はゴーストメソッドではなく、動的メソッドで定義された特異メソッドを使う為に特異メソッドを定義する
        @instance
      end

      def create_accessors
        instance.hash.each do |key, value|
          create_accessor_method(key)
        end
      end

      def create_accessor_method(key)
        define_singleton_method(key) do
          instance.send(key)
        end
      end
  end

  attr_accessor(:hash)

  def initialize(nest_hash = {})
    file_content = File.read(self.class.source)
    if nest_hash.empty?
      @hash = YAML.load(file_content)
      @hash = @hash[self.class.namespace]
    else
      @hash = nest_hash
    end
    create_accessors
  end

  private
    def create_accessors
      hash.each do |key, value|
        create_accessor_method(key, value)
      end
    end

    def create_accessor_method(key, value)
      # selfはsetting
      self.class.define_method(key) do
        if value.class == Hash
          self.class.new(value)
        else
          value
        end
      end
    end
end