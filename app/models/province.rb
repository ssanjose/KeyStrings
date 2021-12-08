class Province < ApplicationRecord
  has_many :users
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  validates :title, :pst, :gst, presence: true
  validates :title, uniqueness: true
  validates :pst, :gst, numericality: true
end
