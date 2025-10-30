require 'rails_helper'

RSpec.describe 'stations/show', type: :view do
  before(:each) do
    assign(:station, Station.create!(
                       registration_number: 'Registration Number',
                       latitude: '9.99',
                       longitude: '9.99',
                       municipality: 'Municipality',
                       station_type: nil,
                       last_name: 'Last Name',
                       first_name: 'First Name',
                       company_name: 'Company Name',
                       email: 'Email',
                       telephone: 'Telephone',
                       mmsi: nil,
                       user: nil,
                       documents: nil
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Registration Number/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Municipality/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Company Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Telephone/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
