class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum is_production: { not_started: 0, waiting_for_start: 1, in_production: 2, completed: 3 }


  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :is_production, presence: true

end
