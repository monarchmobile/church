class UserMailer < ActionMailer::Base
    default from: "from@example.com"

	def announcement_notice(announcement)
        @announcement = announcement
        groups = @announcement.send_list_array
        user_list = []
        groups.each do |g|
        	role_id = Role.find_by_id(g).id
        	all_users = User.all 
        	all_users.each do |u|
        		if !user_list.include?(u.id)
    	    		if u.role_ids.include?(role_id)
    	    			user_list.push(u.id)
    	    		end
    	    	end
        	end
        end
        @users = User.where("id in (?)", user_list)
        @users.each do |user|
        	@user = user
        	mail :to => user.email, :subject => "New announcement"
        end

        @announcement.sent = true
     	@announcement.save!
    end

end