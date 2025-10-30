require 'rails_helper'

RSpec.describe "stations/edit", type: :view do
  let(:station) {
    Station.create!(
      registration_number: "MyString",
      latitude: "9.99",
      longitude: "9.99",
      municipality: "MyString",
      station_type: nil,
      last_name: "MyString",
      first_name: "MyString",
      company_name: "MyString",
      email: "MyString",
      telephone: "MyString",
      mmsi: nil,
      user: nil,
      documents: nil
    )
  }

  before(:each) do
    assign(:station, station)
  end

  it "renders the edit station form" do
    render

    assert_select "form[action=?][method=?]", station_path(station), "post" do

      assert_select "input[name=?]", "station[registration_number]"

      assert_select "input[name=?]", "station[latitude]"

      assert_select "input[name=?]", "station[longitude]"

      assert_select "input[name=?]", "station[municipality]"

      assert_select "input[name=?]", "station[station_type_id]"

      assert_select "input[name=?]", "station[last_name]"

      assert_select "input[name=?]", "station[first_name]"

      assert_select "input[name=?]", "station[company_name]"

      assert_select "input[name=?]", "station[email]"

      assert_select "input[name=?]", "station[telephone]"

      assert_select "input[name=?]", "station[mmsi_id]"

      assert_select "input[name=?]", "station[user_id]"

      assert_select "input[name=?]", "station[documents]"
    end
  end
end
