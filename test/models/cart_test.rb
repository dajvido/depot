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

  test 'should decrement book quantity from 2 to 1' do
    cart = create_cart_with_2_books(products(:one), products(:one))
    line_item = LineItem.find_by_product_id(products(:one))
    cart.decrement_line_item_quantity(line_item.id).save!
    assert_equal 1, cart.line_items.find_by(product_id: products(:one).id).quantity
  end

  test 'should decrement(destroy) book quantity from 1 to 0' do
    cart = Cart.create
    cart.add_product(products(:one).id, products(:one).price).save!
    line_item = LineItem.find_by_product_id(products(:one))
    cart.decrement_line_item_quantity(line_item.id).save!
    assert_nil cart.line_items.find_by(product_id: products(:one).id)
  end
end
