class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  enum :role, { user: 0, admin: 1 }.freeze

  after_initialize :set_default_values, if: :new_record?
  has_many :stations
  has_many :mmsis
  has_many :vessels
  has_many :callsigns

  def active_for_authentication?
    super && !banned?
  end

  def inactive_message
    banned? ? :banned : super
  end

  private

  def set_default_values
    self.role ||= :user
    self.banned ||= false
  end
end
