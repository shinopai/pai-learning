class Comment < ApplicationRecord
  # relation
  belongs_to :user
  belongs_to :post

  # validation
  validates :body,
            presence: true,
            length: { maximum: 500 }
end
