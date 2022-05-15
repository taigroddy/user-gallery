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

  describe 'GET show' do
    let(:action) { get(:show, params: { id: gallery.id }) }

    before(:each) do
      action
    end

    it 'assigns @gallery @photos' do
      expect(assigns(:gallery)).to eq(gallery)
      expect(assigns(:photos)).to eq([])
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    let(:action) { get(:new) }

    before(:each) do
      action
    end

    it 'assigns @gallery' do
      expect(assigns(:gallery).id).to eq(nil)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'GET edit' do
    let(:action) { get(:edit, params: { id: gallery.id }) }

    before(:each) do
      action
    end

    it 'assigns @gallery' do
      expect(assigns(:gallery)).to eq(gallery)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'POST create' do
    let(:params) { { gallery: FactoryBot.build(:gallery).as_json } }
    let(:permit_params) { params }
    let(:action) { post(:create, params: permit_params) }

    context '#success' do
      it 'Gallery.count change to up 1' do
        expect { action }.to change(Gallery, :count).by(1)
      end

      it 'redirect to index page' do
        expect(action).to redirect_to(gallery_path(Gallery.last))
      end
    end

    context '#error' do
      let(:permit_params) { params.merge({ gallery: { name: Gallery.first.name } }) }

      it 'Gallery.count change to up 0' do
        expect { action }.to change(Gallery, :count).by(0)
      end

      it 'redirect to index page' do
        expect(action).not_to redirect_to(gallery_path(Gallery.last))
      end
    end
  end

  describe 'PUT update' do
    let(:params) { { gallery: FactoryBot.create(:gallery).as_json.merge(({ 'name': name })) } }
    let(:name) { 'new name' }
    let(:permit_params) { params }
    let(:action) { put(:update, params: permit_params.merge(id: Gallery.last.id)) }

    context '#success' do
      it { expect(action).to redirect_to(gallery_path(Gallery.last)) }
      it do
        action
        expect(Gallery.last.name).to eq(name)
      end
    end

    context '#error' do
      let(:permit_params) { params.merge({ gallery: { name: Gallery.first.name }, id: Gallery.last.id }) }

      it { expect(action).not_to redirect_to(gallery_path(Gallery.last)) }
      it do
        action
        expect(Gallery.last.name).not_to eq(name)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:permit_params) { { id: Gallery.last.id } }
    let(:action) { delete(:destroy, params: permit_params) }

    context '#success' do
      it { expect { action }.to change(Gallery, :count).by(-1) }
      it { expect(action).to redirect_to(galleries_path) }
    end

    context '#error' do
      let(:permit_params) { { id: 1_000_000 } }

      it { expect { action }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
