require 'rails_helper'

RSpec.describe "station_types/edit", type: :view do
  let(:station_type) {
    StationType.create!(
      category: "MyString"
    )
  }

  before(:each) do
    assign(:station_type, station_type)
  end

  it "renders the edit station_type form" do
    render

    assert_select "form[action=?][method=?]", station_type_path(station_type), "post" do

      assert_select "input[name=?]", "station_type[category]"
    end
  end
end
