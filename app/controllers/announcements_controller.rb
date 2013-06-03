class AnnouncementsController < ApplicationController 

	layout :resolve_layout
	load_and_authorize_resource	
	def index
		reset_current_state(Announcement)
		all_announcement_states
		@announcements = Announcement.all
	end

	def new
		@announcement = Announcement.new
		@recipients = Role.all
		@announcement.send_list = []
		@announcement.show_list = []
	end

	def create
		@announcement = Announcement.new(params[:announcement])
		respond_to do |format|
			if @announcement.save
				@announcement.send_announcement_email
				format.html { redirect_to announcements_path }
				format.js
			else
				format.html { redirect_to new_announcement_path, :notice => "You must fill out all required fields"}
				format.js
			end
		end
	end
	
	def show
		respond_to do |format|
			format.html { render @announcement }
			format.js
		end
	end

	def announcement_partial
		reset_current_state(Announcement)
    @announcements_partial = Describe.new(Announcement).partial.published
    @model_name = "Announcement"
    render 'shared/quick_partial_view', model_name: @model_name
  end
  
	def edit
		@announcement.send_list = []
		@announcement.show_list = []
		@recipients = Role.all
		respond_to do |format|
			format.html { render 'edit' }
			format.js
		end
	end

	def update
		all_announcement_states
		position = params[:announcement][:position]
		current_state = params[:announcement][:current_state]
		published = Status.find_by_status_name("published").id
		if (!current_state ==  published) 
			@announcement.position = nil
		end
		respond_to do |format|
			if @announcement.update_attributes(params[:announcement])
				format.html { redirect_to dashboard_path, notice: "changes saved" }
				format.js
			end
		end
	end

	def destroy
		@announcement.destroy
		respond_to do |format|
			format.html { redirect_to dashboard_path }
			format.js
		end
	end

	def announcement_status
		all_announcement_states
		current_state = params[:announcement][:current_state]
		total_published = @published_announcements.count
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			@announcement.update_attributes({current_state: current_state, position: total_published})
		else
			@announcement.update_attributes({current_state: current_state, position: nil})
		end
		@published_announcements.each_with_index do |id, index|
	    @published_announcements.update_all({position: index+1}, {id: id})
	  end
		render "update.js"

	end

	def announcement_starts_at
		all_announcement_states
		starts_at = params[:announcement][:starts_at]
		current_state = params[:announcement][:current_state]
		total_published = @published_announcements.count

		@announcement.update_attributes({starts_at: starts_at})
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			@published_announcements.each_with_index do |id, index|
		    @published_announcements.update_all({position: index+1}, {id: id})
		  end
		end
		
	  all_announcement_states
		render "update.js"
	end

	def announcement_ends_at
		all_announcement_states
		ends_at = params[:announcement][:ends_at]
		current_state = params[:announcement][:current_state]
		total_published = @published_announcements.count
		
		@announcement.update_attributes({ends_at: ends_at})
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			@published_announcements.each_with_index do |id, index|
		    @published_announcements.update_all({position: index+1}, {id: id})
		  end
		end
	  all_announcement_states
		render "update.js"
		
	end

	def sort
		all_announcement_states
		params[:announcement].each_with_index do |id, index|
	    Announcement.update_all({position: index+1}, {id: id})
	  end
		render "update.js"
	end

	def all_announcement_states
		@published_announcements = Describe.new(Announcement).published
    @scheduled_announcements = Describe.new(Announcement).scheduled
    @draft_announcements = Describe.new(Announcement).draft

	end

	def hide
		ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
		cookies.permanent.signed[:hidden_announcement_ids] = ids
		redirect_to :back
	end
end