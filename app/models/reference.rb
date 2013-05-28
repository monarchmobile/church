class Reference < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :email, :phone_number, :user_id

	belongs_to :user
end