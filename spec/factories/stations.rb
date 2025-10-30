FactoryBot.define do
  factory :station do
    registration_number { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    municipality { "MyString" }
    station_type { nil }
    last_name { "MyString" }
    first_name { "MyString" }
    company_name { "MyString" }
    email { "MyString" }
    telephone { "MyString" }
    mmsi { nil }
    user { nil }
    documents { nil }
  end
end
