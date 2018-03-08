class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.content.maximum}
  validate :picture_size

  scope :desc, ->{order created_at: :desc}
  scope :feeds, ->user{where "user_id IN (?) OR user_id = ?", user.following_ids, user.id}

  private

  def picture_size
    return if picture.size <= 5.megabytes
    errors.add :picture, "should be less than 5 MB"
  end
end
