class Frame < ApplicationRecord
validates :message, presence: true

belongs_to :user
end
