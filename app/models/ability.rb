class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    cannot :manage, :all

    user ||= User.new # guest user (not logged in)

    can :manage, :all if user.is_a? Admin

    if user.is_a? Secretary
      can :manage, Doctor
      can :manage, ContactInfo
      can :manage, Secretary
    end

    if user.is_a? Doctor
      can :read, Doctor
      can :read, ContactInfo
      can :read, Secretary
      can :update, Doctor, :id => user.id
      can :manage, ContactInfo, :reachable_id => user.id
    end

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
