class AffiliationsController < ApplicationController
  layout :resolve_layout
  authorize_resource
  def index
    church_lists
    respond_to do |format|
      format.html 
    end
  end

  def show
    load_affiliation
    respond_to do |format|
      format.html
    end
  end

  def new
    @affiliation = Affiliation.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    load_affiliation
  end

  def create
    @affiliation = Affiliation.new(params[:affiliation])

    respond_to do |format|
      if @affiliation.save
        format.html { redirect_to affiliations_path, notice: 'Affiliation was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    load_affiliation
    respond_to do |format|
      if @affiliation.update_attributes(params[:affiliation])
        if params[:action] == "index"
          church_lists
          format.js
        else
          format.html { redirect_to @affiliation, notice: 'Affiliation was successfully updated.' }
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    load_affiliation
    @affiliation.destroy

    respond_to do |format|
      format.html { redirect_to affiliations_path }
    end
  end

  def load_affiliation
    @affiliation = Affiliation.find(params[:id])
    rescue_code
  end

  def church_lists
    @approved_churches = Affiliation.where(approved: true)
    @non_approved_churches = Affiliation.where(approved: false)
  end
end
