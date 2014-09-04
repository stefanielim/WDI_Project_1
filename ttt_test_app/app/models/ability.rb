class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.persisted?
      can :read, User
      can [:create, :read], [Game, Move]
    else
      can :create, User
    end
  end
  
end