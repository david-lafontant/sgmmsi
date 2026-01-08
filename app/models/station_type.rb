class StationType < ApplicationRecord
  has_many :stations

  string_regex = Regexp.new(/\A(?=.{3,40}\z)[A-Za-z-]+(?: [A-Za-z-]+)*\z/, Regexp::IGNORECASE)
  validates :category, presence: true, format: { with: string_regex, message: 'invalid format' }
end
