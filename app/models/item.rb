class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre # ジャンルは必須
  validates :genre, presence: true # バリデーションを追加（ジャンルが必須であることを明示）
end
