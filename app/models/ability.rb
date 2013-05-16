class Ability
  include CanCan::Ability
  
  def initialize(user)
    # Always performed
    # can :access, :ckeditor   # needed to access Ckeditor filebrowser

    # Performed checks for actions:
    # can [:read, :create, :destroy], Ckeditor::Picture
    # can [:read, :create, :destroy], Ckeditor::AttachmentFile
    # can [:create], User
              # allow everyone to read everything
              # add ability to create comments
    # user ||= User.new   

    # #guest
    # can :create, Prayer 
    # can :search, User 
    # can :create, Affiliation 
    # can :create, User 

    # if user.role? :SuperAdmin       ### SUPERADMIN ###
      can :manage, :all 

    # elsif user.role? :Admin         ### ADMIN ###
    #   can :manage, :all
      
    # elsif user.role? :Coordinator   ### MODERATOR ###
    #   can :update, User do |u|
    #     u.affiliation == user.affiliation && user.role?(:Coordinator) #checks if comment belongs to user
    #   end
    #   can :read, Prayer

    # elsif user.role? :Intercessor   ### INTERCESSOR ###
    #   can :read, Prayer
    #   can :show, User
    # end
  end
end



