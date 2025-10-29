require 'rails_helper'

RSpec.describe "vessels/new", type: :view do
  before(:each) do
    assign(:vessel, Vessel.new(
      registration_number: "MyString",
      operation_area: "MyString",
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

  it "renders new vessel form" do
    render

    assert_select "form[action=?][method=?]", vessels_path, "post" do

      assert_select "input[name=?]", "vessel[registration_number]"

      assert_select "input[name=?]", "vessel[operation_area]"

      assert_select "input[name=?]", "vessel[last_name]"

      assert_select "input[name=?]", "vessel[first_name]"

      assert_select "input[name=?]", "vessel[company_name]"

      assert_select "input[name=?]", "vessel[email]"

      assert_select "input[name=?]", "vessel[telephone]"

      assert_select "input[name=?]", "vessel[mmsi_id]"

      assert_select "input[name=?]", "vessel[user_id]"

      assert_select "input[name=?]", "vessel[documents]"
    end
  end
end
