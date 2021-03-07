require_relative('./lib/drapper.rb')
require('date')

class Book
  include(Drapper::Decoratable)

  attr_accessor(:published, :published_at)

  def initialize(attrs = {})
    @published = attrs[:published] || false
    @published_at = attrs[:published_at]
  end

  def published?
    published
  end

  class << self
    def book_class_method
      'book calss method'
    end
  end
end

class BookDecorator < Drapper::Decorator
  delegate_all

  def publish_status
    published? ? published_at : 'not published'
  end
end

book = Book.new(published: true, published_at: Date.today)
book_decorator = book.decorate
puts(book_decorator.class.book_class_method)
puts(book_decorator.publish_status)