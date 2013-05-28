class ReferencesController < ApplicationController
	def new
		@reference = Reference.new
		respond_to do |format|
	      format.js
	    end
	end


	def create 
		@reference = Reference.new(params[:reference])
	    respond_to do |format|
	      if @reference.save
	        format.js
	      else
	        format.html { render action: "new" }
	        format.json { render json: @reference.errors, status: :unprocessable_entity }
	      end
	    end
	end
end