class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  before_save :calculate_total_amount

  validates :status, presence: true

  enum status: {
      pending: "pending",
      processing: "processing",
      shipped: "shipped",
      delivered: "delivered",
      cancelled: "cancelled",
      refunded: "refunded"
    }

  private

  def calculate_total_amount
    self.total_amount = order_items.sum { |item| item.price * item.quantity }
  end
end
