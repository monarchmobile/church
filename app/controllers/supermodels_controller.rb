class SupermodelsController < ApplicationController
 
	layout 'dashboard'
	load_and_authorize_resource

	def new 
		@supermodel = Supermodel.new
	end

	def index 
		all_supermodel_states
		@supermodels = Supermodel.all(:order => "visible ASC, name ASC")
	end

	def show
	end

	def create
		@supermodel = Supermodel.find(params[:supermodel])
		respond_to do |format|
			if @supermodel.save
				format.html { redirect_to dashboard_path, "model saved" }
				format.js
			else
				format.html { render 'new', notice: "model not saved" }
				format.js
			end
		end
	end

	def edit 

	end

	def update
		authorize! :update, @supermodel
		all_supermodel_states
		respond_to do |format|
	      if @supermodel.update_attributes(params[:supermodel])
	        format.html { redirect_to dashboard_path, notice: 'model was successfully updated.' }
	        format.js
	      else
	        format.html { render action: "edit" }
	        format.js { render json: @supermodel.errors, status: :unprocessable_entity }
	      end
	    end

	end

	def sort
		all_supermodel_states
		params[:supermodel].each_with_index do |id, index|
			Supermodel.update_all({ position: index+1}, {id: id })
		end
		render 'update.js'

	end

	def model_status
		all_supermodel_states
		visible = params[:supermodel][:visible]
		@supermodel.update_attributes({visible: visible})
		Supermodel.visible.each_with_index do |id, index|
			Supermodel.update_all({position: index+1}, {id: id})
		end
		render 'update.js'

	end

	def all_supermodel_states
		@visible_supermodels = Supermodel.visible.order("name ASC")
		@hidden_supermodels = Supermodel.hidden.order("name ASC")
	end

end