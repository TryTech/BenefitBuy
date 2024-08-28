class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  before_save :calculate_amount_cents

  monetize :amount_cents

  validates :status, presence: true

  enum :status, [ :pending, :processing, :shipped, :delivered, :cancelled, :refunded ]

  private

  def calculate_amount_cents
    self.amount_cents = order_items.sum { |item| item.price * item.quantity }
  end
end
