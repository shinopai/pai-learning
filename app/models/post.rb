class Post < ApplicationRecord
  # validation
  validates :title, :question, :answer,
            presence: true
  validates :title,
            length: { maximum: 30 }
  validates :question,
            length: { maximum: 200 }
  validates :answer,
            length: { maximum: 200 }

  # relation
  belongs_to :user
  belongs_to :category
end
