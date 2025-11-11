require 'rails_helper'

RSpec.describe 'callsigns/edit', type: :view do
  let(:callsign) do
    Callsign.create!(
      call_sign_num: 'MyString',
      mmsi: nil,
      user: nil,
      status: false,
      documents: nil
    )
  end

  before(:each) do
    assign(:callsign, callsign)
  end

  it 'renders the edit callsign form' do
    render

    assert_select 'form[action=?][method=?]', callsign_path(callsign), 'post' do
      assert_select 'input[name=?]', 'callsign[call_sign_num]'

      assert_select 'input[name=?]', 'callsign[mmsi_id]'

      assert_select 'input[name=?]', 'callsign[user_id]'

      assert_select 'input[name=?]', 'callsign[status]'

      assert_select 'input[name=?]', 'callsign[documents]'
    end
  end
end
