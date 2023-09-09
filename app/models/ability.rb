class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present?

    can :manage, Comment, author_id: user.id # Allow users to create, edit, and delete their own comments
    can :read, Comment # Allow users to read all comments
    can :create, Comment # Allow users to create comments

    can :manage, Post, author_id: user.id # Allow users to manage their own posts

    return unless user.role == 'admin'

    can :manage, :all # Allow admin users to manage all resources
  end
end
