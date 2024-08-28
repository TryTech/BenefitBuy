class ChangeOrdersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :orders, :total_amount, :decimal

    add_monetize :orders, :amount
    add_column :orders, :checkout_session_id, :string
  end
end
