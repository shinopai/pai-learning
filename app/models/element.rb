class Element < ApplicationRecord
  # relation
  belongs_to :collection
  belongs_to :post

  # validation
  validates :collection_id, uniqueness: { scope: :post_id}
end
