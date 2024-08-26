require "test_helper"

class AddressTest < ActiveSupport::TestCase
  setup do
    @address = addresses(:one)
  end

  test "should not save address without street" do
    @address.street = nil
    assert_not @address.save, "Saved the address without a street"
  end

  test "should not save address without city" do
    @address.city = nil
    assert_not @address.save, "Saved the address without a city"
  end

  test "should not save address without state" do
    @address.state = nil
    assert_not @address.save, "Saved the address without a state"
  end

  test "should not save address without postal_code" do
    @address.postal_code = nil
    assert_not @address.save, "Saved the address without a postal_code"
  end

  test "should not save address without country" do
    @address.country = nil
    assert_not @address.save, "Saved the address without a country"
  end

  test "should save address" do
    @address.street = "New street"
    assert @address.save, "Did not save the address"
  end
end
