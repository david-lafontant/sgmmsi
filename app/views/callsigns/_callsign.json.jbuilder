json.extract! callsign, :id, :call_sign_num, :mmsi_id, :user_id, :status, :documents, :created_at, :updated_at
json.url callsign_url(callsign, format: :json)
json.documents do
  json.array!(callsign.documents) do |document|
    json.id document.id
    json.url url_for(document)
  end
end
