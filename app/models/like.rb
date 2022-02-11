class Like < ApplicationRecord
  # relation
  belongs_to :user
  belongs_to :post

  # validation
  validates :user_id, uniqueness: { scope: :post_id}
end
