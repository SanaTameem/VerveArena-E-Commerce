class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all # All users can read everything
    return unless user.present? # Stop here if user is not signed in

    can %i[create update destroy], CartItem
    can %i[create destroy], Order, user_id: user.id
    can :create, Payment
    return unless user.admin? # Stop here if user is not an admin

    can :manage, :all
  end
end
