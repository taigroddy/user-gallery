# == Schema Information
#
# Table name: photos
#
#  id                 :bigint           not null, primary key
#  image_content_type :string           not null
#  image_file_name    :string           not null
#  image_file_size    :bigint           not null
#  image_updated_at   :datetime         not null
#  name               :string
#  shooting_date      :datetime
#  short_description  :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  gallery_id         :bigint           not null
#
# Indexes
#
#  index_photos_on_gallery_id  (gallery_id)
#  index_photos_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (gallery_id => galleries.id)
#
class Photo < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  validates :gallery_id, presence: true

  belongs_to :gallery
  has_attached_file :image
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}
end
