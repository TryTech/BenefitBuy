require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
  end

  test "should not save order without status" do
    @order.status = nil

    assert_not @order.save
  end

  test "should save order with status" do
    @order.status = :pending
    assert @order.save
  end

  test "should calculate total amount" do
    order_item = order_items(:one)
    order_item.price = 10
    order_item.quantity = 2
    order_item.save

    @order.order_items << order_item
    @order.status = :pending
    @order.save

    assert_equal Float(20), @order.amount_cents.to_f
  end

  test "should has many order items" do
    assert_respond_to @order, :order_items
  end

  test "should belongs to user" do
    assert_respond_to @order, :user
  end
end
