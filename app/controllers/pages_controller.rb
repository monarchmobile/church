class PagesController < ApplicationController 
	# before_filter :authenticate_user!, :except => [:show] # devise method
	layout :resolve_layout
	authorize_resource
	def new 
		@page = Page.new
		all_page_states
	end

	def index
		all_page_states
		publish_page_if_in_range
	end

	def show 
		load_page
		@links = Link.all
		reset_current_state(Announcement)
		reset_current_state(Event)
		reset_current_state(Blog)
		publish_page_if_in_range
		sidebar_partials
		@prayer = Prayer.new
		
	end

	def edit 
		load_page
		all_page_states
	end

	def create 
		@page = Page.new(params[:page])
		respond_to do |format|
			if @page.save
				format.html { redirect_to @page, :notice => "The #{@page.title} page was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "page could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		load_page
		all_page_states
		position = params[:page][:position]
		current_state = params[:page][:current_state]
		published = Status.find_by_status_name("published").id
		draft = Status.find_by_status_name("draft").id
		@page.check_start_date
		if (!current_state ==  published) 
			@page.position = nil
		end

		respond_to do |format|
			if @page.update_attributes(params[:page])
				# reorder_pages(@page)
				format.html { redirect_to @page, :notice => "The #{@page.title} page was succesfully updated"}
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		load_page
		@page.link_ids=[]
		@page.destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js
		end
	end

	def sort
		all_page_states
	  params[:page].each_with_index do |id, index|
	    Page.update_all({position: index+1}, {id: id})
	  end
	  render "update.js"
	end

	def status
		all_page_states
		current_state = params[:page][:current_state]
		total_published = @published_pages.count
		published = Status.find_by_status_name("published").id
		if (current_state.to_i == published) 
			if @page.starts_at.blank?
				@page.update_attributes({current_state: current_state, starts_at: Date.today})
			else
				@page.update_attributes({current_state: current_state})
			end
		else
			@page.update_attributes({current_state: current_state, position: nil })
		end

		@published_pages.each_with_index do |id, index|
	    @published_pages.update_all({position: index+1}, {id: id})
	  end
		render "update.js"
	  
	end

	def link
	  load_page
	  if @page.update_attributes(params[:page])
	  	all_page_states
	  	render "update.js"
	  end
	end

	def all_page_states
		@published_pages = Describe.new(Page).published
		@scheduled_pages = Describe.new(Page).scheduled
		@draft_pages = Describe.new(Page).draft
		@links = Link.all
		@partials = Partial.all
	end

	def load_page
		@page = Page.find(params[:id])
	end


end