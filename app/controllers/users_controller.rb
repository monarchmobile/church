class UsersController < Devise::RegistrationsController
  authorize_resource
  layout :resolve_layout
  def index
    @roles = index_page_roles
  end

  def new
    @user = User.new
    @guest_roles = Role.where("name IN (?)", ["Intercessor", "Coordinator"]).order("name DESC")
    @user.references.build
    render :layout => 'application'
  end

  def show
    load_user
    if @user 
      recent_prayers_for_intercessor(@user) if @user.approved
      @prayer = Prayer.new
      @categories = @recent_prayers.group_by { |t| t.category } if current_user.approved
      sidebar_partials
      # respond_to do |format|
      #   format.html
      #   format.pdf do
      #     pdf = OrderPdf.new
      #     send_data pdf.render, filename: "prayer list for #{current_user.last_name}.pdf"
      #   end
      # end
    else
      rescue_code
    end
  end

  def edit
    load_user
    @admin_roles = Role.all
  end

  def create
    @user = User.new(params[:user])
    if !params[:user][:affiliation].blank?
      @affiliation = Affiliation.find(params[:user][:affiliation])
      if @affiliation
        @affiliation.users << @user
        @user.affiliation = @affiliation
      else
        @affiliation = User.create_affiliation
        @affiliation.users << @user
        @user.affiliation = @affiliation
      end
    end
    
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
    load_user
    @approved_status = params[:user][:approved] if params[:user][:approved]
    if params[:user][:role_ids]
      @user.role_ids = params[:user][:role_ids]
    end
      
    respond_to do |format|
      if !@approved_status.blank?
        if @user.update_attributes(approved: @approved_status)
          @roles = index_page_roles
          format.js
        end
      else
        if @user.update_attributes(params[:user])
          if (current_user.role_ids & [role_id(:SuperAdmin), role_id(:Admin), role_id(:Coordinator)]).count > 0
            format.html { redirect_to users_path, :notice => "user updates were successful"}
          else
            format.html { redirect_to @user, :notice => "changes updated" }
          end
        else
          format.html { redirect_to :edit, :notice => "changes did not take"}
        end
      end
    end
  end
    
  def destroy
    load_user
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

    

    @coor_list_ints_waiting = User.not_approved.with_role(role_id(:coordinator)).where(affiliation_id: current_user.affiliation_id)
    @coor_list_ints_approved = User.approved.with_role(role_id(:coordinator)).where(affiliation_id: current_user.affiliation_id)
    # @admin_list_ints_waiting = ApprovalStatus.new(:intercessor, :waiting)
    # @admin_list_coords_waiting = User.not_approved.with_role(role_id(:coordinator))
    # @admin_list_admins_waiting = User.not_approved.with_role(role_id(:admin))
    # @admin_list_ints_approved = User.approved.with_role(role_id(:intercessor))
    # @admin_list_coords_approved = User.approved.with_role(role_id(:coordinator))
    # @admin_list_admins_approved = User.approved.with_role(role_id(:admin))
   
  end

  def load_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, :flash => { :error => "Record not found." }
  end

  def user_prayer_list
    @user = User.find(params[:id])
    recent_prayers_for_intercessor
    @categories = @recent_prayers.group_by { |t| t.category } if current_user.approved
    render :layout => "plain"
  end
end