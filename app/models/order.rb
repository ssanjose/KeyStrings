class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount
  has_many   :order_histories

  validates :taxes, :price, :created, presence: true
  validates :price, numericality: true
end
