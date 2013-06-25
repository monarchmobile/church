class Prayerlist
	def initialize(time_frame)
		@time_frame = time_frame
	end

	def query
		query = {
	    this_week: Prayer.where("prayers.created_at >= ?", Date.today.beginning_of_week),
	    past_week: Prayer.expiring_within_the_week,
	    past_month: Prayer.expiring_within_the_month
	  }

	  query[@time_frame]
	end

	def count
		query.count
	end
end