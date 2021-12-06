class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  validates :email, presence: true,
                    format:   { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Must be a valid email address" }
  validates :name, :password, presence: true
  validates :email, uniqueness: true
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }
end
