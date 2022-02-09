class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # validation
  validates :name,
            presence: true,
            length: { maximum: 30 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relation
  has_many :posts

  # carrierwave
  mount_uploader :user_image, UserImageUploader
end
