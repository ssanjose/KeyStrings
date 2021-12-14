class Item < ApplicationRecord
  belongs_to :category
  has_many   :order_histories

  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
end
