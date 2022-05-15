# == Schema Information
#
# Table name: galleries
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  short_description :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_galleries_on_name     (name) UNIQUE
#  index_galleries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Gallery < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  validates :short_description, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :photos, dependent: :destroy
end
