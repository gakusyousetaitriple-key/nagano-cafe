class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, bank_transfer: 1 }


  enum is_order: { waiting_for_payment: 0, payment_confirmed: 1, in_production: 2, shipping_preparation: 3, shipped: 4 }

  # カート内商品の合計金額を計算
  def calculate_total_amount(cart_items)
    self.total_amount = cart_items.sum do |cart_item|
      cart_item.item.price * cart_item.amount
    end
  end

  # 送料を設定する（例: 一律800円）
  def set_postage
    self.postage = 800
  end


  validates :address, :post_code, :name, :total_amount, :postage, :payment_method, presence: true
  validates :is_order, presence: true
end
