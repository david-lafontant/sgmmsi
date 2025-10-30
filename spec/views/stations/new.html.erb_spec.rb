require 'rails_helper'

RSpec.describe "stations/new", type: :view do
  before(:each) do
    assign(:station, Station.new(
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
    ))
  end

  it "renders new station form" do
    render

    assert_select "form[action=?][method=?]", stations_path, "post" do

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
