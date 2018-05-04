class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validate :event_author_cant_subscribe
  validates :user_name, presence: true unless 'user.present?'
  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ unless 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :email_present_in_user?

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  private
  def email_present_in_user?
    if user.blank? && User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t('error.email_exist'))
    end
  end
  # TODO
  def event_author_cant_subscribe
    if user == event.user
      errors.add(:user_name, 'Нельзя подписать себя')
    end
  end
end
