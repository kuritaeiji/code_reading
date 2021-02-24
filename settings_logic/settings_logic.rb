require('yaml')
require('pry-byebug')

class SettingsLogic
  class << self
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
        @instance ||= new
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
      self.class.define_method(key) do
        if value.class == Hash
          self.class.new(value)
        else
          value
        end
      end
    end
end