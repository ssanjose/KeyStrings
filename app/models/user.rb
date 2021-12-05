class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :phone, numericality: { only_integer: true }
end
