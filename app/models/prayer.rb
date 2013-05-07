class Prayer < ActiveRecord::Base  
  attr_accessible :duration, :request, :pray_for_first_name, :pray_for_last_name
  attr_accessible :share_with, :category
  attr_accessible :user_first_name, :user_last_name, :user_email, :church
  attr_accessible :new_church_name, :church_city, :church_state
  # attr_accessible :comments_attributes

  # has_many :comments
  belongs_to :user
  # accepts_nested_attributes_for :comments, allow_destroy: :true

  # a prayer will have one category, can just choose from list, will be an integer
  # a prayer belongs to user, needs user_id and association
  # a 
  # set new affliation from request form
  attr_accessor :user_first_name, :user_last_name, :user_email, :church
  attr_accessor :new_church_name, :church_city, :church_state
  before_save :create_affiliation_from_church
  before_save :create_user
  # after_save :send_new_prayer

  # validates :request,
  # 	:presence => { :message => "can't be blank" }

  # validates :fullname,
  #   :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
  #   :presence => {:message => "can't be blank"}

  # validates :email, 
  # 	:presence => { :message => "can't be blank"},
  # 	:email_pattern => true 

  # # church affiliation 
  # validates :affiliation_id,
  #   :presence => { :message => "select from the drop down or add a new church"}
  # validates :new_church_name,
  #   :presence => { :message => "add your church or select from drop down"}

  # validates :expiration,
  # 	:presence => { :message => "can't be blank" }

  validates :category,
  	:presence => { :message => "can't be blank" }

  # scopes
  # scope :prayers_still_current, where(["expiration > ?", Date.today])

  def create_user
    user = User.where(email: user_email)
    if user.blank?
      date = Date.today.to_s
      password = user_email+date
      @user = User.new(:first_name => user_first_name, :last_name => user_last_name, :email => user_email, password: password, password_confirmation: password)      
      @user.save!
      guest = Role.find_by_name("Guest").id 
      @user.role_ids=[guest]
    end
  end

  def create_affiliation_from_church
  	Affiliation.create(:church => new_church_name, :city => church_city, :state => church_state) unless new_church_name.blank?
  end

  # def send_new_prayer
  # 	RequestMailer.new_prayer_request(self).deliver
  # end

  # def self.send_follow_up_email_to_prayer_requestor
  #   today = Date.today.strftime("%b %d, %Y")
  #   Prayer.all.each do |pr|
  #     if pr.duration == "1"
  #       num = 0
  #     elsif pr.duration == "2"
  #       num = 7
  #     elsif pr.duration == "3"
  #       num = 30
  #     end
  #     num = num.to_i
  #     expiration = pr.created_at.to_date+@num.days
  #     expiration = expiration.strftime("%b %d, %Y")
  #     if expiration == today
  #       RequestMailer.follow_up(self).deliver
  #     end
  #   end
    
  # end

  # def fullname 
  # 	[first_name, last_name].join(" ")
  # end

  # def fullname=(name)
  # 	split = name.split(" ", 2)
  # 	self.first_name = split[0]
  # 	self.last_name = split[1]
  # end


  # method to allow user to create a new category
  # def create_category_name
  # 	create_category(:name => new_category_name) unless new_category_name.blank?
  # end
end
