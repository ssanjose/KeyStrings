class Item < ApplicationRecord
  belongs_to :category
  has_one_attached :picture
end
