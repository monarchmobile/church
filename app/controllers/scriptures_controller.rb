class ScripturesController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource
  def index
    @scriptures = Scripture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scriptures }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scripture }
    end
  end


  def new
    @scripture = Scripture.new

    respond_to do |format|
      format.html
    end
  end


  def edit
  end


  def create
    @scripture = Scripture.new(params[:scripture])

    respond_to do |format|
      if @scripture.save
        format.html { redirect_to scriptures_path}
      else
        format.html { render action: "new" }
        format.json { render json: @scripture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @scripture.update_attributes(params[:scripture])
        format.html { redirect_to scriptures_path, notice: 'scripture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scripture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @scripture.destroy

    respond_to do |format|
      format.html { redirect_to scriptures_url }
      format.js
    end
  end

end
