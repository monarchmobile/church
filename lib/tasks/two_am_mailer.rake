desc "Send new mailing list to intercessors"
task :two_am_mailer => :environment do
	include ApplicationHelper
	if Time.now.monday?
		two_am_mailer
	end
end