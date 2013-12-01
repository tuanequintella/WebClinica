#encoding: utf-8
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
      can :manage, Office
      can :manage, Pacient
      can :manage, Agenda
      can :manage, Appointment
      can :manage, HealthInsurance
      cannot :manage, HealthInsurance, :name => "Sem convênio (particular)"
      can :manage, Occupation
      can :manage, Record
      can :search, Record
      can :manage, RecordEntry
      can :manage, AppointmentAttachment
    end

    if user.is_a? Doctor
      can :read, Doctor
      can :read, ContactInfo
      can :read, Secretary
      can :read, Office
      can :read, HealthInsurance
      can :read, Occupation
      can :read, Agenda, :doctor_id => user.id
      can :read, Appointment, :agenda_id => user.agenda.id
      can :manage, Record
      can :manage, RecordEntry
      can :manage, AppointmentAttachment
      can :manage, Pacient
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
