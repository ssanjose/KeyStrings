class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount
  has_many   :order_histories

  validates :price, presence: true, numericality: true
end
