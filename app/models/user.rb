class User < ActiveRecord::Base 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
	attr_accessible :first_name, :last_name, :role, :username, :approved
  attr_accessible :affiliation, :affiliation_id
  attr_accessible :new_church_name, :church_city, :church_state
  attr_accessor :new_church_name, :church_city, :church_state, :affiliation
  attr_accessible :role_ids
  has_and_belongs_to_many :roles
  before_create :setup_role
  # before_create :attach_affiliation
  has_many :prayers, dependent: :destroy
  belongs_to :affiliation
  ## acts_as_orderer

  def self.approved
    where(approved: true)
  end

  def self.not_approved
    where(approved: false)
  end

  def self.order_by_name
    order("last_name ASC")
  end

  def role?(role)
   return !!self.roles.find_by_name(role.to_s)
  end

  scope :with_role, lambda { |role_id| { :joins => :roles, 
                                             :conditions => {:roles => {:id => role_id} } } }

  def fullname
  	[first_name, last_name].join(" ")
  end

  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def fullname=(name)
  	split = name.split(" ")
  	first_name = split[0]
  	last_name = split[1]
  end

  def attach_affiliation
    church = Affiliation.find(self.affiliation_id)
  end

  def create_affiliation
    @affiliation = Affiliation.create(:church => new_church_name, :city => church_city, :state => church_state) unless new_church_name.blank?
  end

  private
  def setup_role
  	guest = Role.find_by_name("Guest")

    if self.role_ids.empty?
      self.role_ids = [guest.id]
    end
  end
  # attr_accessible :title, :body
end
