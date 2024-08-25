class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :user, presence: true
  validates :category, presence: true
end
