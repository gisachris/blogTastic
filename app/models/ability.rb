# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Common abilities for all users
    can :read, :all

    if user.role == 'admin'
      can :manage, :all
    else
      # Abilities for regular users
      can :manage, [Post, Comment], author_id: user.id
    end
  end
end
