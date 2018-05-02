class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validate :uniq_email
  
  unless 'user.present?'
  	validates :user_name, presence: true
  	validates :user_email, presence: true, format: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  end

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'

  def user_name
  	if user.present?
			user.name
  	else
  		super
  	end
  end

  def user_email
  	if user.present?
			user.email
  	else
  		super
  	end
	end

  private
  def uniq_email
    if User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t('error.email_exist'))
    end
  end

end
