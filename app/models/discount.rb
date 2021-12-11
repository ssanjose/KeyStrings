class Discount < ApplicationRecord
  has_many :orders
  validates :title, :discount, :from, :till, presence: true
  validates :discount, numericality: true
end
