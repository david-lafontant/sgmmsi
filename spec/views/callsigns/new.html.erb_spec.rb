require 'rails_helper'

RSpec.describe "callsigns/new", type: :view do
  before(:each) do
    assign(:callsign, Callsign.new(
      call_sign_num: "MyString",
      mmsi: nil,
      user: nil,
      status: false,
      documents: nil
    ))
  end

  it "renders new callsign form" do
    render

    assert_select "form[action=?][method=?]", callsigns_path, "post" do

      assert_select "input[name=?]", "callsign[call_sign_num]"

      assert_select "input[name=?]", "callsign[mmsi_id]"

      assert_select "input[name=?]", "callsign[user_id]"

      assert_select "input[name=?]", "callsign[status]"

      assert_select "input[name=?]", "callsign[documents]"
    end
  end
end
