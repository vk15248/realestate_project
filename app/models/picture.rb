class Picture < ApplicationRecord
  belongs_to :real_estate
  mount_uploader :name, PictureUploader
end
