require 'rails_helper'

RSpec.describe 'callsigns/index', type: :view do
  before(:each) do
    assign(:callsigns, [
             Callsign.create!(
               call_sign_num: 'Call Sign Num',
               mmsi: nil,
               user: nil,
               status: false,
               documents: nil
             ),
             Callsign.create!(
               call_sign_num: 'Call Sign Num',
               mmsi: nil,
               user: nil,
               status: false,
               documents: nil
             )
           ])
  end

  it 'renders a list of callsigns' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new('Call Sign Num'), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
