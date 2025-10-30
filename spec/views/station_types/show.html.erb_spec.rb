require 'rails_helper'

RSpec.describe 'station_types/show', type: :view do
  before(:each) do
    assign(:station_type, StationType.create!(
                            category: 'Category'
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Category/)
  end
end
