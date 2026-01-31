module CallsignConcern
  include ActiveSupport::Concern

  def generate_callsign
    "call003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end

  def get_callsign(id)
    Callsign.find_by(mmsi_id: id).call_sign_num
  end
end
