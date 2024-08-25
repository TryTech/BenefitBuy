require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
  end

  test "should not save product without name" do
    @product.name = nil
    assert_not @product.save, "Saved the product without a name"
  end

  test "should not save product without stock" do
    @product.stock = nil
    assert_not @product.save, "Saved the product without stock"
  end

  test "should not save product without price" do
    @product.price = nil
    assert_not @product.save, "Saved the product without price"
  end

  test "should not save product without user" do
    @product.user = nil
    assert_not @product.save, "Saved the product without user"
  end

  test "should not save product without category" do
    @product.category = nil
    assert_not @product.save, "Saved the product without category"
  end

  test "should save product" do
    @product.name = "New product"
    assert @product.save, "Did not save the product"
  end

  test "should not save product with negative stock" do
    @product.stock = -1
    assert_not @product.save, "Saved the product with negative stock"
  end

  test "should not save product with zero price" do
    @product.price = 0
    assert_not @product.save, "Saved the product with zero price"
  end

  test "should not save product with negative price" do
    @product.price = -1
    assert_not @product.save, "Saved the product with negative price"
  end

  test "should save product with positive stock" do
    @product.stock = 1
    assert @product.save, "Did not save the product with positive stock"
  end

  test "should has many order items" do
    assert_respond_to @product, :order_items
  end

  test "should belong to user" do
    assert_respond_to @product, :user
  end

  test "should belong to category" do
    assert_respond_to @product, :category
  end

  test "should order items dependent destroy" do
    assert_difference("OrderItem.count", -1) do
      @product.destroy
    end
  end
end
