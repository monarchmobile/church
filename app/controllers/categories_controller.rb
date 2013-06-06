class CategoriesController < ApplicationController
  layout :resolve_layout
  load_and_authorize_resource
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end


  def new
    @category = Category.new
    @scriptures = Scripture.all
    @category.scripture_list = []
    respond_to do |format|
      format.html
    end
  end


  def edit
    @scriptures = Scripture.all
    @category.scripture_list = []
  end


  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path}
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.js
    end
  end

end
