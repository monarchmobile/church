class EmailList
	def initialize(time_frame)
		@time_frame = time_frame
	end

	def prayer_list
		prayer_list_array = []
    Prayerlist.new(@time_frame).query.map { |p| prayer_list_array.push(p.id) }
    return prayer_list_array
	end

	def list_for_user(index, user_count)
    user_step_array = ((index)..(prayer_list.count-1)).step(user_count)
    new_prayer_list = []
    user_step_array.each { |c1| new_prayer_list.push(prayer_list[c1]) }
    Prayer.where("id In (?)", new_prayer_list)
	end

end
