require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  setup do
    @order_item = order_items(:one)
  end

  test "should belong to order" do
    assert_not_nil @order_item.order
  end

  test "should belong to product" do
    assert_not_nil @order_item.product
  end
end
