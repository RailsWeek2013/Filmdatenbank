class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    unless user.role
        user.role = Role.find_by name: "Gast"
    end
    if user.admin?
        can :manage, :all
    else
        if user.moderator?
            can :manage, Film
            can :manage, Message
            can :manage, Question
            can :manage, Comment
        else
            if user.user?
                can :create, Film
                can :read, Film
                can :review, Film
                can :top, Film
                can :tagsearch, Film
                can :quiz, Question
                can :solve, Question
                can :create, Question
                can :create, Comment
                can :read, Comment
                can :create, Message
                can :read, Message
                can :delete, Message
                can :update, Message
                can :outbox, Message
            else
                can :read, Film
                can :top, Film
                can :tagsearch, Film
                can :read, Comment
                can :quiz, Question
                can :solve, Question
            end
        end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
