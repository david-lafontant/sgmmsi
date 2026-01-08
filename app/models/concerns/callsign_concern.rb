module CallsignConcern
  include ActiveSupport::Concern

  def generate_callsign
    "call003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end
end
