class RealEstate < ApplicationRecord
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :lat, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :lon, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :pictures, length: {maximum: 10, message: 'Only 10 pictures allowed'}
  validates :room_number, numericality: {only_integer: true, greater_than: 0}
  validates :size, numericality: {greater_than: 0}
  validates :floor, numericality: {only_integer: true}

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user, class_name: "User"
  has_many :pictures, dependent: :destroy
  geocoded_by :address # can also be an IP address
  reverse_geocoded_by :lat, :lon
  after_validation :reverse_geocode # auto-fetch address

  def liked?(user)
    user_likes.include?(user)
  end
end
