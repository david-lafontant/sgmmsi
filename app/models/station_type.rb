class StationType < ApplicationRecord
  has_many :stations

  string_regex = Regexp.new(/\A[A-Za-z\s]{3,50}\z/, Regexp::IGNORECASE)
  validates :category, presence: true, format: { with: string_regex, message: 'invalid format' }
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
