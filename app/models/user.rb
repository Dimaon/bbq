class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :comments
  has_many :subscriptions


  # validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, length: {maximum: 255}

  before_validation :set_name, on: :create

  private
  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end
end
