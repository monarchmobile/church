desc "Send new mailing list to intercessors"
task :two_am_mailer => :environment do
	include ApplicationHelper
	two_am_mailer
end