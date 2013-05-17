class PartialsController < ApplicationController
	layout :resolve_layout
	load_and_authorize_resource
	def new
		@partial = Partial.new
	end

	def index
		@partials = Partial.all 
	end

	def show
		
	end

	def edit
		
	end

	def create
		@partial = Partial.new(params[:partial])
		respond_to do |format|
			if @partial.save
				format.html { redirect_to partials_path }
				format.js
			else
				format.html { render action: "new" }
	      format.json { render json: @link.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @partial.update_attributes(params[:partial])
				format.html { redirect_to partials_path }
				format.js
			else
				format.html
				format.js
			end
		end
	end

	def destroy
		@partial.page_ids=[]
		@partial.destroy
		respond_to do |format|
			format.html { redirect_to partials_path }
			format.js
		end
	end

end