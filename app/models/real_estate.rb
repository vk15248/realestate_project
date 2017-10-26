class RealEstate < ApplicationRecord
  validates :price, presence: true
  validates :lat, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :lon, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :pictures, length: { maximum: 10, message: 'Only 10 pictures allowed'}
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user, class_name: "User"
  has_many :pictures, dependent: :destroy

  def liked?(user)
    user_likes.include?(user)
  end
end
