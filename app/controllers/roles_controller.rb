class RolesController < ApplicationController 
	layout 'dashboard'
	load_and_authorize_resource
	def new 
		@role = Role.new	
	end

	def index
		@roles = Role.all 
	end

	def show 
	end

	def edit 
	end

	def create 
		@role = Role.new(params[:role])
		respond_to do |format|
			if @role.save
				format.html { redirect_to @role, :notice => "The #{@role.name} role was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "role could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		respond_to do |format|
			if @role.update_attributes(params[:role])
				format.html { redirect_to @role, :notice => "The #{@role.name} role was succesfully updated"}
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		@role.destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js
		end
	end

end