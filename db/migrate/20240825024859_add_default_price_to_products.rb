class AddDefaultPriceToProducts < ActiveRecord::Migration[7.2]
  def change
    change_column_default :products, :price, from: nil, to: 0
  end
end
