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
  validates :call_sign_num, presence: true, format: {
    with: /\Acall003290\d{5}\z/,
    message: 'invalid format'
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      call_sign_num
      mmsi_id
      user_id
      status
      created_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[mmsi user]
  end
end
