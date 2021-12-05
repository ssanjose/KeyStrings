class Province < ApplicationRecord
  has_many :customer
  validates :title, :pst, :gst, presence: true
  validates :title, uniqueness: true
  validates :pst, :gst, numericality: true
end
