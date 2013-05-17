class AffiliationsController < ApplicationController
  layout :resolve_layout
  def index
    @affiliations = Affiliation.order("church ASC")

    respond_to do |format|
      format.html 
    end
  end

  def show
    @affiliation = Affiliation.find(params[:id])

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
    @affiliation = Affiliation.find(params[:id])
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
    @affiliation = Affiliation.find(params[:id])

    respond_to do |format|
      if @affiliation.update_attributes(params[:affiliation])
        format.html { redirect_to affiliations_path, notice: 'Affiliation was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @affiliation = Affiliation.find(params[:id])
    @affiliation.destroy

    respond_to do |format|
      format.html { redirect_to affiliations_path }
    end
  end
end
