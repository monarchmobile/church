class AffiliationsController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource
  def index
    @affiliations = Affiliation.order("church ASC")

    respond_to do |format|
      format.html 
    end
  end

  def show
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

    respond_to do |format|
      if @affiliation.update_attributes(params[:affiliation])
        format.html { redirect_to affiliations_path, notice: 'Affiliation was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @affiliation.destroy

    respond_to do |format|
      format.html { redirect_to affiliations_path }
    end
  end
end
