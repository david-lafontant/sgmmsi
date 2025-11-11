class Callsign < ApplicationRecord
  belongs_to :mmsi
  belongs_to :user
  has_many_attached :documents

  after_initialize :set_default_status, if: :new_record?

  def display_mmsi(id)
    Mmsi.find(id).mmsi_id
  end

  def display_user(id)
    User.find(id).email
  end

  private

  def set_default_status
    self[:status] ||= false
  end

  def generate_callsign
    "call003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end
end
