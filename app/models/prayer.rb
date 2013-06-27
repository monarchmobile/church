class Prayer < ActiveRecord::Base  
  attr_accessible :duration, :request, :pray_for_first_name, :pray_for_last_name, :we_care
  attr_accessible :share_with, :category, :user_id
  attr_accessible :user_first_name, :user_last_name, :user_email, :affiliation
  attr_accessible :new_church_name, :church_city, :church_state
  # attr_accessible :comments_attributes

  # has_many :comments
  belongs_to :user
  # accepts_nested_attributes_for :comments, allow_destroy: :true

  # a prayer will have one category, can just choose from list, will be an integer
  # a prayer belongs to user, needs user_id and association
  # a 
  # set new affliation from request form
  attr_accessor :user_first_name, :user_last_name, :user_email, :affiliation
  attr_accessor :new_church_name, :church_city, :church_state
  # before_save :create_affiliation_from_church
  before_save :create_user
  before_save :limit_pray_for
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
    if user.blank? # new user
      @user = create_new_user
      church = nil
      if affiliation.blank?
        church = create_affiliation_from_church
      else
        church = Affiliation.find(self.affiliation)
      end
      @user.affiliation = church
      church.users << @user
      @user.save

      guest = Role.find_by_name("Guest").id 
      @user.role_ids=[guest]
      self.user_id = @user.id
    end
  end

  def create_new_user
    date = Date.today.to_s
    password = user_email+date
    @user = User.create(:first_name => user_first_name, :last_name => user_last_name, :email => user_email, password: password, password_confirmation: password, approved: false)
  end

  def create_affiliation_from_church
  	affiliation = Affiliation.create(:church => new_church_name, :city => church_city, :state => church_state) unless new_church_name.blank?
  end

  def limit_pray_for
    name = self.pray_for_first_name
    self.pray_for_first_name = name.split(" ") ? name.split(" ")[0] : name
  end

  def affiliation=(id)
    @affiliation = id
  end

  def affiliation
    @affiliation
  end

  def self.beg_of_last_week
    Date.today.beginning_of_week-7.days
  end

  def self.end_of_last_week
    Date.today.end_of_week-7.days
  end

  def self.expiring_within_the_week
    where("prayers.created_at >= ? AND prayers.created_at < ?", beg_of_last_week.beginning_of_day+2.hours, end_of_last_week)
  end

  def self.expiring_within_the_month
    where("prayers.created_at >= ? AND prayers.created_at < ?", beg_of_last_week-30.days, end_of_last_week-30.days)
  end

  def category_name(id)
    category = Category.find(id).name
  end


  def send_new_prayer
    
    users = User.where(approved: true)
    users.each do |user|
      UserMailer.new_prayer_request(self, user).deliver
    end
  	
  end


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
