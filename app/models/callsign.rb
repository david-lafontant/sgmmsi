class Callsign < ApplicationRecord
  include EmailConcern
  include CallsignConcern
  include MmsiConcern
  include UserConcern

  belongs_to :mmsi
  belongs_to :user
  has_many_attached :documents

  validate :user_id_exists
  validate :mmsi_id_exists
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self[:status] ||= true
  end
end
