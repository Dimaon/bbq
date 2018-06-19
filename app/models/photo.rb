class Photo < ApplicationRecord
  belongs_to :event
  # Чтобы знать кто загрузил фотку
  belongs_to :user

  validates :event, :user, :photo, presence: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where 'id IS NOT NULL'}
end
