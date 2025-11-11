require 'rails_helper'

RSpec.describe 'callsigns/show', type: :view do
  before(:each) do
    assign(:callsign, Callsign.create!(
                        call_sign_num: 'Call Sign Num',
                        mmsi: nil,
                        user: nil,
                        status: false,
                        documents: nil
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Call Sign Num/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
