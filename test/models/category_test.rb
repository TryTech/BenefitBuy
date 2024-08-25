require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
  end

  test "should not save category without name" do
    @category.name = nil
    assert_not @category.save, "Saved the category without a name"
  end

  test "should not save category without description" do
    @category.description = nil
    assert_not @category.save, "Saved the category without a description"
  end

  test "should save category" do
    @category.name = "New category"
    assert @category.save, "Did not save the category"
  end

  test "should not save category with duplicate name" do
    category = Category.new(name: @category.name, description: "Another description")
    assert_not category.save, "Saved the category with a duplicate name"
  end

  test "should have many products" do
    assert_respond_to @category, :products, "Does not have many products"
  end
end
