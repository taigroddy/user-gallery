require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:gallery) { FactoryBot.create(:gallery, user_id: user.id) }
  let(:photo) { FactoryBot.create(:photo, gallery_id: gallery.id) }
  let(:image_file) { Rack::Test::UploadedFile.new('spec/fixtures/test-image.png', 'image/png') }

  before(:each) do
    sign_in user
    photo
  end

  describe 'GET show' do
    let(:action) { get(:show, params: { id: photo.id, gallery_id: gallery.id }) }

    before(:each) do
      action
    end

    it 'assigns @photo' do
      expect(assigns(:photo)).to eq(photo)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    let(:action) { get(:new, params: { gallery_id: gallery.id }) }

    before(:each) do
      action
    end

    it 'assigns @photo' do
      expect(assigns(:photo).id).to eq(nil)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'GET edit' do
    let(:action) { get(:edit, params: { id: photo.id, gallery_id: gallery.id }) }

    before(:each) do
      action
    end

    it 'assigns @photo' do
      expect(assigns(:photo)).to eq(photo)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        photo: FactoryBot.build(:photo).as_json.merge(image: image_file),
        gallery_id: gallery.id
      }
    end
    let(:permit_params) { params }
    let(:action) { post(:create, params: permit_params) }

    context '#success' do
      it 'Photo.count change to up 1' do
        expect { action }.to change(Photo, :count).by(1)
      end

      it 'redirect to index page' do
        expect(action).to redirect_to(gallery_path(gallery.id))
      end
    end

    context '#error' do
      let(:permit_params) { params.merge({ photo: { name: Photo.first.name } }) }

      it 'Photo.count change to up 0' do
        expect { action }.to change(Photo, :count).by(0)
      end

      it 'redirect to index page' do
        expect(action).not_to redirect_to(gallery_path(gallery.id))
      end
    end
  end

  describe 'PUT update' do
    let(:params) do
      {
        photo: FactoryBot.build(:photo).as_json.merge(image: image_file, name: name),
        gallery_id: gallery.id
      }
    end
    let(:name) { 'new name' }
    let(:permit_params) { params }
    let(:action) { put(:update, params: permit_params.merge(id: Photo.last.id)) }

    context '#success' do
      it { expect(action).to redirect_to(gallery_photo_path(gallery_id: gallery.id, id: Photo.last.id)) }
      it do
        action
        expect(Photo.last.name).to eq(name)
        expect(Photo.last.image_file_name).to eq(image_file.original_filename)
      end
    end

    context '#error' do
      let(:permit_params) { params.merge({ photo: { name: Photo.first.name }, id: Photo.last.id }) }

      it { expect(action).not_to redirect_to(gallery_path(Photo.last)) }
      it do
        action
        expect(Photo.last.name).not_to eq(name)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:permit_params) { { id: Photo.last.id, gallery_id: gallery.id } }
    let(:action) { delete(:destroy, params: permit_params) }

    context '#success' do
      it { expect { action }.to change(Photo, :count).by(-1) }
      it { expect(action).to redirect_to(gallery_path(gallery.id)) }
    end

    context '#error' do
      let(:permit_params) { { id: 1_000_000, gallery_id: gallery.id } }

      it { expect { action }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
