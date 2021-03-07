module Drapper
  module Decoratable
    extend(ActiveSupport::Concern)

    def decorate
      class_name.new(self)
    end

    def class_name
      self.class.decorator_class
    end

    module ClassMethods
      def decorator_class
        class_name = self.to_s
        decorator_name = "#{class_name}Decorator"
        const_get(decorator_name)
      end
    end
  end
end