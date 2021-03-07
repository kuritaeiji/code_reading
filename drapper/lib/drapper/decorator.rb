module Drapper
  class Decorator
    attr_accessor(:target)

    def initialize(target)
      @target = target
    end

    class << self
      def delegate_all
        include(Delegator)
      end

      def object_class
        class_name = self.to_s.sub('Decorator', '')
        @object_name ||= const_get(class_name)
      end
    end
  end
end