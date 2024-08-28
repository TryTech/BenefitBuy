class ChangeDecimalToMonetize < ActiveRecord::Migration[7.2]
  def change
    remove_column :order_items, :price, :decimal
    add_monetize :order_items, :price, currency: { present: false }

    remove_column :products, :price, :decimal
    add_monetize :products, :price, currency: { present: false }
  end
end
