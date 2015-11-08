class Ability
  include CanCan::Ability

  # alias_action :create, :read, :update, :destroy, to: :crud

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.employee?
      can :crud, [Meeting, Visitor]
    elsif  user.receptionist?
      can :read, :all
    end
  end
end