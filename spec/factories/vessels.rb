FactoryBot.define do
  factory :vessel do
    registration_number { 'MyString' }
    operation_area { 'MyString' }
    last_name { 'MyString' }
    first_name { 'MyString' }
    company_name { 'MyString' }
    email { 'MyString' }
    telephone { 'MyString' }
    mmsi { nil }
    user { nil }
    documents { nil }
  end
end
