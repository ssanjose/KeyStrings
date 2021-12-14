class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount
  has_many   :order_histories

  validates :pst, :gst, :price, presence: true, numericality: true
end
