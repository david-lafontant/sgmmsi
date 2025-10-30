class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  enum :role, { user: 0, admin: 1 }.freeze
  has_many :mmsis
  has_many :vessels
  has_many :stations

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
