require 'rails_helper'

RSpec.describe 'station_types/new', type: :view do
  before(:each) do
    assign(:station_type, StationType.new(
                            category: 'MyString'
                          ))
  end

  it 'renders new station_type form' do
    render

    assert_select 'form[action=?][method=?]', station_types_path, 'post' do
      assert_select 'input[name=?]', 'station_type[category]'
    end
  end
end
