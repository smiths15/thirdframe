class Frame < ApplicationRecord
validates :message, presence: true
mount_uploader :picture, PictureUploader

belongs_to :user, optional: true
end
