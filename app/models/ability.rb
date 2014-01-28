class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_a?(Admin)
      can :manage, :all
    elsif user.is_a?(Instructor)
      can :manage, user
      can :read, Instructor
      can :read, Student
      can :manage, user.school
      can :read, School
    elsif user.is_a?(Student)
      can :manage, user
      can :read, Instructor
      can :read, Student
      can :read, School
    end

  end
end
