require 'rails_helper'

RSpec.describe StationTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/station_types').to route_to('station_types#index')
    end

    it 'routes to #new' do
      expect(get: '/station_types/new').to route_to('station_types#new')
    end

    it 'routes to #show' do
      expect(get: '/station_types/1').to route_to('station_types#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/station_types/1/edit').to route_to('station_types#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/station_types').to route_to('station_types#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/station_types/1').to route_to('station_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/station_types/1').to route_to('station_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/station_types/1').to route_to('station_types#destroy', id: '1')
    end
  end
end
