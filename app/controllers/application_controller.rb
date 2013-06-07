 class ApplicationController < ActionController::Base
	protect_from_forgery
	include ApplicationHelper
	rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = "Access denied."
	  redirect_to main_app.root_url
	end

	def after_sign_in_path_for(resource)
		superadmin = Role.find_by_name(:SuperAdmin)
		admin = Role.find_by_name(:Admin)
		fullAccess = %w(superadmin.id admin.id)
		role_ids = current_user.role_ids
		if (fullAccess & role_ids).empty? 
			root_path
		else 
			dashboard_path
	  end
	end

	def recent_prayers_for_intercessor
		affiliation = Affiliation.find(current_user.affiliation_id)
		@recent_prayers = Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).where("prayers.created_at >= ?", Date.today.beginning_of_week)
    @prayers_with_week_duration = Prayer.expiring_within_the_week
    @prayers_with_month_duration = Prayer.expiring_within_the_month
	end

	def sidebar_partials
		@announcement = Describe.new(Announcement).published.limit(1).order("created_at DESC").first
    @blogs_partial = Describe.new(Blog).published.limit(5).order("starts_at DESC")
    @events_partial = Describe.new(Event).published.limit(5).order("starts_at DESC")
    @announcements_partial = Describe.new(Announcement).published.limit(5).order("starts_at DESC")
    @partials = Partial.all
  end

	private

	def resolve_layout
		case action_name
		when "show"
		  "application"
		when "index", "edit", "new"
		  "dashboard"
		else
		  "application"
		end
	end

  

  
end