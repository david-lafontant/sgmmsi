json.extract! station, :id, :registration_number, :latitude, :longitude, :municipality, :station_type_id, :last_name, :first_name, :email,
              :telephone, :mmsi_id, :user_id, :documents, :created_at, :updated_at
json.url station_url(station, format: :json)
json.documents do
  json.array!(station.documents) do |document|
    json.id document.id
    json.url url_for(document)
  end
end
