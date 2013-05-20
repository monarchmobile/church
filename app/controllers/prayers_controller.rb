class PrayersController < ApplicationController 
  layout 'dashboard', :except => [:new, :prayer_partial]
  load_and_authorize_resource
  def index
    @recent_prayers = Prayer.where("created_at >= ?", Date.today.beginning_of_week)
    @prayers_with_week_duration = Prayer.expiring_within_the_week
    @prayers_with_month_duration = Prayer.expiring_within_the_month
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prayers }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prayer }
    end
  end


  def new
    @found = params[:found]
    @prayer = Prayer.new
    # @user = User.search(params[:search])
    # comments = @prayer.comments.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prayer }
    end
  end

  def prayer_partial
    @prayer = Prayer.new
    @prayers_partial = Prayer.new
    @model_name = "Prayer"
    render 'shared/quick_partial_view', model_name: @model_name
    
  end

  def edit
    
  end

  def create
    @prayer = Prayer.new(params[:prayer])
    user = User.find_by_email(params[:prayer][:user_email])
    @prayer.user = user

    respond_to do |format|
      if @prayer.save
        format.html { redirect_to current_user || root_path, notice: 'Prayer req was successfully created.' }
        format.json { render json: @prayer, status: :created, location: @prayer }
      else
        format.html { render action: "new" }
        format.json { render json: @prayer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @prayer.update_attributes(params[:prayer])
        format.html { redirect_to @prayer, notice: 'Prayer req was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @prayer.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @prayer.destroy

    respond_to do |format|
      format.html { redirect_to prayers_url }
      format.json { head :no_content }
    end
  end


end
