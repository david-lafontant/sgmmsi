json.extract! vessel, :id, :registration_number, :operation_area, :last_name, :first_name, :company_name, :email, :telephone, :mmsi_id, :user_id, :documents,
              :created_at, :updated_at
json.url vessel_url(vessel, format: :json)
json.documents do
  json.array!(vessel.documents) do |document|
    json.id document.id
    json.url url_for(document)
  end
end
