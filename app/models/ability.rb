class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.subscription.plan.name == "Free"
      # I don't have the private attribute on wikis yet, so I'm restricting ability to create wikis
      # can :manage, Wiki, :user_id => user.id
      can :read, Wiki
    end

    if user.subscription.plan.name == "Premium"
      can :manage, Wiki, :user_id => user.id 
    end
  end
end
