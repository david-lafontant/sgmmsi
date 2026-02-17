class StationType < ApplicationRecord
  has_many :stations

  VALID_STATUTS = [
    'COTIERE',
    'PORTUAIRES',
    'PILOTAGE',
    'REPETEUR AIS',
    'BASE AIS'
  ].freeze

  string_regex = Regexp.new(/\A[[:alpha:]][[:alnum:]\- ]*\z/u, Regexp::IGNORECASE)
  validates :category, presence: true, length: { in: 3..40 }, format: { with: string_regex, message: 'invalid format' }, inclusion: {
    in: VALID_STATUTS,
    message: 'invalid format'
  }

  before_save :upcase_inputs
  def self.ransackable_attributes(_auth_object = nil)
    %w[category
       created_at
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[stations]
  end

  private

  def upcase_inputs
    self.category = category.strip.upcase
  end
end
