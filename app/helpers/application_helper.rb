module ApplicationHelper
# ********************** START Stock Methods START ********************
  def question_for_andrew(text)
    content_tag(:div, text, class: "andrew")
  end

  # user methods
  def restrict_access
    redirect_to root_url, notice: "access denied"
  end

  def current_users_page?(user)
    current_user && current_user.id == user.id
  end

  def authorize_dashboard(user)
    redirect_to root_path unless (user.role_ids & [1,2]).length > 0
  end

    # generates red stars for required fields in any form
  def required_field
    content_tag :span, "**", class: "required_field"
  end

  def update_list
    models = ActiveRecord::Base.connection.tables.collect{|t| t.underscore.singularize.camelize}
    models.each do |m|
      if Supermodel.find(:all, conditions: {name: m }).count == 0
        Supermodel.create(name: m, visible: false)
      end
    end
    client_models = ["Role", "Page", "Announcement", "Profile", "Partial"]
    client_models.each do |cm|
      instance = Supermodel.find_by_name(cm)
      instance.update_attributes(visible: true)
    end
  end

  def rescue_code
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, :flash => { :error => "Record not found." }
  end

  # this removes events and blogs from dashboard, not needed as of yet
  def category_name(cat_id)
    category = Category.find(cat_id.to_i)
    category.name
  end
  def check_status(blog)
    if blog.published == true
      "published"
    else 
      "draft"
    end
  end

  def current_status(id)
    Status.find(id).status_name
  end

  
  def reset_current_state(model)
    scheduled = Status.find_by_status_name("scheduled").id
    published = Status.find_by_status_name("published").id
    draft = Status.find_by_status_name("draft").id
    anns = Describe.new(model).partial
    anns.each do |a|
      if !a.starts_at.blank? && a.starts_at <= Date.today
        a.update_attributes(current_state: published)
      elsif !a.starts_at.blank? && a.starts_at > Date.today
        a.update_attributes(current_state: scheduled)
      end
      
      if !a.ends_at.blank? && a.ends_at <= Date.today-1
        a.update_attributes(current_state: draft)
      end

      if a.starts_at.blank?
        a.update_attributes(current_state: draft)
      end
    end
  end

  def publish_page_if_in_range
    scheduled = Status.find_by_status_name("scheduled").id
    published = Status.find_by_status_name("published").id
    draft = Status.find_by_status_name("draft").id
    pages = Page.all
    pages.each do |a|
      if !a.starts_at.blank? && a.starts_at <= Date.today
        count = (Describe.new(Page).published.count)
        a.update_attributes(current_state: published)
      elsif !a.starts_at.blank? && a.starts_at > Date.today
        a.update_attributes(current_state: scheduled)
      end
      
      if !a.ends_at.blank? && a.ends_at <= Date.today-1
        a.update_attributes(current_state: draft)
      end

      if a.starts_at.blank?
        a.update_attributes(current_state: draft)
      end
    end
  end
# ###################### END Stock Methods END #######################

###################### page #################
  def handle_if_published(page)
    if Describe.new(page).is_published?
      "[drag]"
    else
      ""
    end
  end

  def position_if_published(page)
    if Describe.new(page).is_published?
      page.position
    else
      ""
    end
  end

  def green_if_checked(page, link_id)
    if page.link_ids.include?(link_id)
      "green_background"
    else
      "red_background"
    end
  end

  def check_if_draft(announcement)
    current_state = announcement.current_state
    draft = Status.find_by_status_name("draft").id
    if current_state == draft
      "hidden"
    end
  end

  def hidden_attributes
    %w[id created_at updated_at]
  end

  def green_if_approved(user)
    if user.approved == true
      "green_background"
    else
      "red_background"
    end
  end

  def green_if_role(user, role_id)
    if user.role_ids.include?(role_id)
      "green_background"
    else
      "red_background"
    end
  end

  # user index
  def user_approved_status(user)
    if user.approved == true
      "Approved"
    elsif user.approved == false
      "Not Approved"
    end
  end

  def role_id(role)
    role = role.to_s.camelize
    Role.find_by_name(role).id
  end

  # static_pages _table_list.  Allows category to become categories
  # <%= pluralize_without_count(item.categories.count, 'Category', ':') %>
  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end

  def scripture_verse(cat)
    scripts = cat.scripture_ids
    @scripture = Scripture.where("id IN(?)", scripts).order("RANDOM()").first
    @scripture.content if @scripture
  end

  def recent_prayers_for_intercessor(user)
    @recent_prayers = prayer_list(user, :this_week )
    @prayers_with_week_duration = prayer_list(user, :past_week )
    @prayers_with_month_duration = prayer_list(user, :past_month )
  end

  def prayer_list(user, key)
    affiliation = Affiliation.find(user.affiliation.id)
    if (user.role_ids & [role_id(:Admin)]).length > 0
      query = {
        this_week: Prayer.where("prayers.created_at >= ?", Date.today.beginning_of_week),
        past_week: Prayer.expiring_within_the_week,
        past_month: Prayer.expiring_within_the_month
      }
    elsif (user.role_ids & [role_id(:Coordinator)]).length > 0
      query = {
        this_week: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).where("prayers.created_at >= ?", Date.today.beginning_of_week),
        past_week: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).expiring_within_the_week,
        past_month: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).expiring_within_the_month
      }
    elsif (user.role_ids & [role_id(:Intercessor)]).length > 0
      query = {
        this_week: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).where("prayers.created_at >= ?", Date.today.beginning_of_week),
        past_week: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).expiring_within_the_week,
        past_month: Prayer.includes(:user).where(:users => {affiliation_id: affiliation.id}).expiring_within_the_month
      }
    end  
    query[key]
  end

  def two_am_mailer
    UserMailer.send_new_list
  end

  

end


