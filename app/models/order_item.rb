class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  monetize :price_cents

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order, presence: true
  validates :product, presence: true
end
