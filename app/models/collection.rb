class Collection < ApplicationRecord
  # relation
  belongs_to :user
  has_many :elements, dependent: :destroy
  has_many :posts, through: :elements

  # validation
  validates :title,
            presence: true,
            length: { maximum: 50 }
end
