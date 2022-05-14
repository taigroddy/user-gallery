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
#  photo_id         :bigint
#
# Indexes
#
#  index_photos_on_photo_id  (photo_id)
#  index_photos_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (photo_id => galleries.id)
#
require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#index' do
    it do
      expect(ActiveRecord::Base.connection.indexes(described_class.table_name).map(&:name))
        .to eq(%w[index_photos_on_gallery_id index_photos_on_name])
    end
  end

  describe '#save' do
    context '#error' do
      before(:each) do
        FactoryBot.create(:photo)
      end

      it 'when duplicate name' do
        expect(Photo.first.dup.save).to eq(false)
      end

      it 'when user_id is nil' do
        photo = Photo.first.dup
        photo.name = Faker::Name.name
        photo.gallery_id = nil

        expect(photo.save).to eq(false)
      end
    end
  end
end
