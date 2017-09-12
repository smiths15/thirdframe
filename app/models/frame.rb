class Frame < ApplicationRecord
validates :message, presence: true
validates :picture, presence: true
mount_uploader :picture, PictureUploader

belongs_to :user, optional: true
has_many :comments
end
