class Post < ApplicationRecord
  # validation
  validates :title, :question, :answer,
            presence: true
  validates :title,
            length: { maximum: 50 }
  validates :question,
            length: { maximum: 300 }
  validates :answer,
            length: { maximum: 300 }

  # relation
  belongs_to :user
  belongs_to :category
end
