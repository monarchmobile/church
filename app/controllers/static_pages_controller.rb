class StaticPagesController < ApplicationController
	before_filter :authenticate_user!
	layout 'dashboard'

	def dashboard
		authorize_dashboard(current_user)
		@pages = Page.all
		static_array = %w[Partial Profile Role Supermodel]
		@active_models = Supermodel.where("visible = true AND name NOT IN (?)", static_array).order("name ASC")
		@static_models = Supermodel.where("visible = true AND name IN (?)", static_array).order("name ASC")
	end
  
end
