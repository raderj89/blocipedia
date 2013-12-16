class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.plan.name == "Free"
      can :create, Wiki, :user_id => user.id
      can :edit, user.shared_wikis
    end

    if user.plan.name == "Premium"
      can :manage, Wiki, :user_id => user.id 
      can :edit, user.shared_wikis
      can :privatize, Wiki, :user_id => user.id
    end
    # can :read, Wiki, public: true
  end
end
