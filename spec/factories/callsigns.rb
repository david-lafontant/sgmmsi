FactoryBot.define do
  factory :callsign do
    call_sign_num { 'MyString' }
    mmsi { nil }
    user { nil }
    status { false }
    documents { nil }
  end
end
