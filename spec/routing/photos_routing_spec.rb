require 'rails_helper'

RSpec.describe PhotosController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: 'galleries/1/photos/new').to route_to('photos#new', gallery_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'galleries/1/photos/1').to route_to('photos#show', id: '1', gallery_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'galleries/1/photos/1/edit').to route_to('photos#edit', id: '1', gallery_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'galleries/1//photos').to route_to('photos#create', gallery_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'galleries/1/photos/1').to route_to('photos#update', id: '1', gallery_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'galleries/1/photos/1').to route_to('photos#update', id: '1', gallery_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'galleries/1/photos/1').to route_to('photos#destroy', id: '1', gallery_id: '1')
    end
  end
end
