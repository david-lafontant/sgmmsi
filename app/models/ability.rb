class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.user?
      can :read, :all
      can %i[create update read], Vessel
      can %i[create update read], Station
      can %i[create read], Mmsi
      can %i[create read], StationType
      can %i[create read], Callsign
      cannot :manage, User
      cannot :invite, User
    else
      cannot :manage, :all
      cannot :invite, User
    end
  end
end
