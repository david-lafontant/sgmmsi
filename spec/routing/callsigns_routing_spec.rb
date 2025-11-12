require 'rails_helper'

RSpec.describe CallsignsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/callsigns').to route_to('callsigns#index')
    end

    it 'routes to #new' do
      expect(get: '/callsigns/new').to route_to('callsigns#new')
    end

    it 'routes to #show' do
      expect(get: '/callsigns/1').to route_to('callsigns#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/callsigns/1/edit').to route_to('callsigns#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/callsigns').to route_to('callsigns#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/callsigns/1').to route_to('callsigns#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/callsigns/1').to route_to('callsigns#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/callsigns/1').to route_to('callsigns#destroy', id: '1')
    end
  end
end
