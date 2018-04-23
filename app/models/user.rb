class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, length: {maximum: 255}
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[a-z\d_+.\-]+@[a-zvj;tn\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
                              message: "incorrect email" }
end
