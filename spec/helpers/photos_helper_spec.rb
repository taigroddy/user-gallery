require 'rails_helper'

RSpec.describe PhotosHelper, type: :helper do
  describe '#url_submit' do
    let(:gallery) { FactoryBot.create(:gallery) }
    let(:photo) { FactoryBot.create(:photo, gallery_id: gallery.id) }

    context 'when photo is new record' do
      it { expect(helper.url_submit(Photo.new, gallery.id)).to eq(gallery_photos_path(gallery_id: gallery.id)) }
    end

    context 'when photo is a record in DB' do
      it { expect(helper.url_submit(photo, gallery.id)).to eq(gallery_photo_path(id: photo.id, gallery_id: gallery.id)) }
    end
  end
end
