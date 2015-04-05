require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  def create_cart_with_2_books(book_1, book_2)
    cart = Cart.create
    cart.add_product(book_1.id, book_1.price).save!
    cart.add_product(book_2.id, book_2.price).save!
    cart
  end

  test 'should add two different books' do
    cart = create_cart_with_2_books(products(:one), products(:two))
    assert_equal 2, cart.line_items.size
    assert_equal products(:one).price + products(:two).price, cart.total_price
  end

  test 'should combine two identical books into one item' do
    cart = create_cart_with_2_books(products(:one), products(:one))
    assert_equal 1, cart.line_items.size
    assert_equal 2 * products(:one).price, cart.total_price
  end
end
