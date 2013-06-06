class Category < ActiveRecord::Base
  attr_accessible :name, :scripture_list, :scripture_ids

  has_and_belongs_to_many :scriptures

end
