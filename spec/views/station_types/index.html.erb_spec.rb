require 'rails_helper'

RSpec.describe "station_types/index", type: :view do
  before(:each) do
    assign(:station_types, [
      StationType.create!(
        category: "Category"
      ),
      StationType.create!(
        category: "Category"
      )
    ])
  end

  it "renders a list of station_types" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Category".to_s), count: 2
  end
end
