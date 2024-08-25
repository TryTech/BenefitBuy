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
end
