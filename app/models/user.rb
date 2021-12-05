class User < ApplicationRecord
  belongs_to :province
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :phone, numericality: { only_integer: true }
end
