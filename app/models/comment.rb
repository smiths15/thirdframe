class Comment < ApplicationRecord
  belongs_to :frame
  belongs_to :user

end
