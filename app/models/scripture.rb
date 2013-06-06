class Scripture < ActiveRecord::Base
	attr_accessible :title, :content

	has_and_belongs_to_many :categories
end