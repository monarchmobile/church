class ProfilesController < ApplicationController 
	layout 'dashboard'
	load_and_authorize_resource
	def new 
		@profile = Profile.new	
	end

	def index
		@profiles = Profile.all 
	end

	def show 
		
	end

	def edit 
		
	end

	def create 
		@profile = Profile.new(params[:profile])
		respond_to do |format|
			if @profile.save
				format.html { redirect_to @profile, :notice => "The #{@profile.name} profile was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "profile could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		respond_to do |format|
			if @profile.update_attributes(params[:profile])
				format.html { redirect_to @profile, :notice => "The #{@profile.name} profile was succesfully updated"}
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		@profile.destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js
		end
	end

end