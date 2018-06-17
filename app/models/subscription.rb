class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, presence: true,
            format: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/, unless: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  
  validate :anonymous_email_must_not_present_in_users
  validate :author_of_event_cant_subscribe_himself

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  private
  def anonymous_email_must_not_present_in_users
    if user.blank? && User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t('error.email_exist'))
    end
  end

  def author_of_event_cant_subscribe_himself
    if user == event.user
      errors.add(:user_name, 'Нельзя подписать себя')
    end
  end
end
