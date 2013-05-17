class UsersController < Devise::RegistrationsController
  load_and_authorize_resource
  layout :resolve_layout
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    all_user_states
  end

  def new
    @guest_roles = Role.find(:all, :conditions => ["name IN (?)", ["Intercessor", "Coordinator"]])
  end

  def show
    recent_prayers_for_intercessor
  end

  def edit
    @admin_roles = Role.all
  end

  def create
    
    @user = User.new(params[:user])
    
    
    if params[:user][:role_ids]
      @user.role_ids = params[:user][:role_ids]
    end
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html {redirect_to @user, :notice => "The #{@user.email} user was successfully created" }
        format.js
      else
        format.html { redirect_to "new", :notice => "something went wrong"}
      end
    end
    
  end
  
  def update
    @approved_status = params[:user][:approved] if params[:user][:approved]
    if params[:user][:role_ids]
      @user.role_ids = params[:user][:role_ids]
    end
      
    respond_to do |format|
      if !@approved_status.blank?
        if @user.update_attributes(approved: @approved_status)
          all_user_states
          format.js
        end
      else
        if @user.update_attributes(params[:user])
          all_user_states
          format.html { redirect_to users_path, :notice => "user udpdate good"}
        else
          format.html { redirect_to dashboard_path, :notice => "user udpdate good"}
        end
      end
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def sort
    all_user_states
    params[:user].each_with_index do |id, index|
      User.update_all({position: index+1}, {id: id})
    end
    render "update.js"
  end

  def search
    email = params[:email]
    @user = User.find_by_email(email)
    if @user.blank?
      @found = false
    else
      @found = true
    end
    # render :js => "window.location = '/?found=#{@found}'"
    respond_to do |format|
      format.js
    end
  end

  def all_user_states
    @intercessors_waiting_to_be_approved = User.not_approved.with_role(role_id(:intercessor))
    @coordinators_waiting_to_be_approved = User.not_approved.with_role(role_id(:coordinator))
    @admins_waiting_to_be_approved = User.not_approved.with_role(role_id(:admin))
    @approved_intercessors = User.approved.with_role(role_id(:intercessor))
    @approved_coordinators = User.approved.with_role(role_id(:coordinator))
    @approved_admins = User.approved.with_role(role_id(:admin))
   
  end
end