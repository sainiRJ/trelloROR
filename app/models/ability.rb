class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    if user.email == 'admin@example.com'
      can :manage, :all 
    elsif user.email == 'rajeshpushpakar01@gmail.com'
      can :manage, Project
    elsif user.email == '123sainisarita@gmail.com'
      can :create, Project
      can :update, Project, user_id: user.id 
    else
      can :read, :all 
    end
  end
end
