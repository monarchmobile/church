class Affiliation < ActiveRecord::Base
  attr_accessible :church, :city, :state, :user_ids

  has_many :users

  def self.list_affiliation_options 
    Affiliation.select("id, church").map {|x| [x.id, x.church] }
  end
end