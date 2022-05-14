require 'rails_helper'

RSpec.describe GalleriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:gallery) { FactoryBot.create(:gallery, user_id: user.id) }

  before(:each) do
    sign_in user
  end

  describe 'GET index' do
    it 'assigns @galleries' do
      get :index
      expect(assigns(:galleries)).to eq([gallery])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET new' do
    it 'assigns @gallery' do
      get :new
      expect(assigns(:gallery).id).to eq(nil)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET edit' do
    it 'assigns @gallery' do
      get :edit, params: { id: gallery.id }
      expect(assigns(:gallery)).to eq(gallery)
    end

    it 'renders the edit template' do
      get :edit, params: { id: gallery.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    context '#success' do
      it 'Gallery.count change to up 1' do
        expect { post :create, params: { gallery: JSON.parse(FactoryBot.build(:gallery).to_json) } }
          .to change(Gallery, :count).by(1)
      end

      it 'redirect to index page' do
        expect(post(:create, params: { gallery: JSON.parse(FactoryBot.build(:gallery).to_json) }))
          .to redirect_to(gallery_path(Gallery.last))
      end
    end
  end
end
