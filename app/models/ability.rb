class Ability
  include CanCan::Ability
  
  def initialize(user)
    # Always performed
    can :access, :ckeditor   # needed to access Ckeditor filebrowser

    # Performed checks for actions:
    can [:read, :create, :destroy], Ckeditor::Picture
    can [:read, :create, :destroy], Ckeditor::AttachmentFile
    can :read, Page
    can [:create], User
    user ||= User.new   

    if user.role? :SuperAdmin
      can :manage, :all 
    elsif user.role? :Admin  
      can :manage, :all 
    elsif user.role? :Coordinator || :Clergy
      can :create, Affiliation
      # can :read, :all
      can :index, [Affiliation, Announcement, Prayer, User]
      can [:show], Announcement
      can [:create, :show], Prayer
      can :create, User
      can :manage, User do |u|
        u.affiliation == user.affiliation && user.role?(:Coordinator) #checks if comment belongs to user
      end
      
    elsif user.role? :Intercessor
      can :create, Affiliation
      can [:index, :show], Announcement
      can [:create, :show], Prayer
      can :create, User
      can [:manage], User do |u|
        u == user
      end
    elsif user.role? :Guest
      can :create, Affiliation
      can [:index, :show], Announcement
      can :create, Prayer
    end
  end
end














    # #guest
    # can :create, Prayer 
    # can :search, User 
    # can :create, Affiliation 
    # can :create, User 
    # can :show, Page

    # if user.role? :SuperAdmin       ### SUPERADMIN ###
    #   can :manage, :all 

    # elsif user.role? :Admin         ### ADMIN ###
    #   can :manage, :all
      
    # elsif user.role? :Coordinator   ### MODERATOR ###
    #   # can :dashboard
    #   can :manage, User do |u|
    #     u.affiliation == user.affiliation && user.role?(:Coordinator) #checks if comment belongs to user
    #   end
      
    #   can :read, Prayer

    # elsif user.role? :Intercessor   ### INTERCESSOR ###
    #   can :read, Prayer
    #   can :manage, User do |u|
    #     u == user
    #   end
    # end
 



