module Drapper
  module Delegator
    extend(ActiveSupport::Concern)

    # selfはbook_decorator
    def method_missing(method, *args, &block)
      super unless delegatable?(method)

      target.send(method, *args, &block)
    end

    def respond_to_missing?(method)
      super || target.respond_to?(method)
    end

    def delegatable?(method)
      return false if private_methods(false).include?(method)

      target.respond_to?(method)
    end

    module ClassMethods
      # selfはBookDecorator
      def method_missing(method, *args, &block)
        super unless delegatable?(method)

        object_class.send(method, *args, &block)
      end

      def respond_to_missing?(method)
        super || object_class.respond_to?(method)
      end

      def delegatable?(method)
        return false if private_methods(false).include?(method)

        object_class.respond_to?(method)
      end
    end
  end
end