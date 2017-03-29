class User < ApplicationRecord
  attr_accessor :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h
  CROP_AVATAR = [:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h]
  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader
end
