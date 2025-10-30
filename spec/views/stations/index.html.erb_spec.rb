require 'rails_helper'

RSpec.describe "stations/index", type: :view do
  before(:each) do
    assign(:stations, [
      Station.create!(
        registration_number: "Registration Number",
        latitude: "9.99",
        longitude: "9.99",
        municipality: "Municipality",
        station_type: nil,
        last_name: "Last Name",
        first_name: "First Name",
        company_name: "Company Name",
        email: "Email",
        telephone: "Telephone",
        mmsi: nil,
        user: nil,
        documents: nil
      ),
      Station.create!(
        registration_number: "Registration Number",
        latitude: "9.99",
        longitude: "9.99",
        municipality: "Municipality",
        station_type: nil,
        last_name: "Last Name",
        first_name: "First Name",
        company_name: "Company Name",
        email: "Email",
        telephone: "Telephone",
        mmsi: nil,
        user: nil,
        documents: nil
      )
    ])
  end

  it "renders a list of stations" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Registration Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Municipality".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Company Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Telephone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
