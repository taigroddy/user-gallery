# == Schema Information
#
# Table name: galleries
#
#  id                :bigint           not null, primary key
#  name              :string
#  short_description :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_galleries_on_name     (name) UNIQUE
#  index_galleries_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe '#index' do
    it do
      expect(ActiveRecord::Base.connection.indexes(described_class.table_name).map(&:name))
        .to eq(%w[index_galleries_on_name index_galleries_on_user_id])
    end
  end

  describe '#save' do
    context '#error' do
      before(:each) do
        FactoryBot.create(:gallery)
      end

      it 'when duplicate name' do
        expect(Gallery.first.dup.save).to eq(false)
      end

      it 'when short_description is nil' do
        gallery = Gallery.first.dup
        gallery.name = Faker::Name.name
        gallery.short_description = nil

        expect(gallery.save).to eq(false)
      end

      it 'when user_id is nil' do
        gallery = Gallery.first.dup
        gallery.name = Faker::Name.name
        gallery.user_id = nil

        expect(gallery.save).to eq(false)
      end
    end
  end
end
