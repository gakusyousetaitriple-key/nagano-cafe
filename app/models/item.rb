class Item < ApplicationRecord
  has_many :order_details
  has_one_attached :image
  belongs_to :genre # ジャンルは必須
  has_many :cart_items
  validates :genre, presence: true # バリデーションを追加（ジャンルが必須であることを明示）
end
