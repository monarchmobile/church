class EmailList
	def initialize(time_frame)
		@time_frame = time_frame
	end

	def prayer_list
		prayer_list_aray = []
    Prayerlist.new(@time_frame).query.each do |p|
        prayer_list_aray.push(p.id)
    end
    return prayer_list_aray
	end

	def list_for_user(index, user_count)
    user_step_array = ((index)..(prayer_list.count-1)).step(user_count)
    new_prayer_list = []
    user_step_array.each do |c1| new_prayer_list.push(prayer_list[c1]) end
    Prayer.where("id In (?)", new_prayer_list)
	end

end
