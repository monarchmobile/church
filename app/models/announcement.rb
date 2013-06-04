class Announcement < ActiveRecord::Base
  attr_accessible :ends_at, :message, :starts_at, :title, :current_state, :position
  attr_accessible :send_list, :sent, :send_list_array, :show_list_array, :show_list
  before_create :set_position
  # after_create :check_announcement_status
  include MyDateFormats
 

  # scope :current, -> { where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)}
  def self.current(hidden_ids = nil)
    result = where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)
    result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
    result
  end

  def send_list_array=(ids)
    self.send_list = ids.join(',')
  end

  # turn into array
  def send_list_array
    new_array = []
    if self.send_list
      if self.send_list.length > 0
        group_array = self.send_list.split(',').to_a
        group_array.each do |g|
          new_array.push(g.to_i)
        end
      end
    end
      
    return new_array
  end

  def show_list_array=(ids)
    self.show_list = ids.join(',')
  end

  # turn into array
  def show_list_array
    new_array = []
    if self.show_list.length > 0
      group_array = self.show_list.split(',').to_a
      group_array.each do |g|
        new_array.push(g.to_i)
      end
    end
      
    return new_array
  end

  def check_announcement_status
    published = Status.find_by_status_name("published").id
    if self.current_state == published
      if self.starts_at.blank?
        self.starts_at = Date.today
        save!
      end
      self.send_announcement_email
    end
    if !self.current_state == published
      if self.starts_at <= Date.today
        self.send_announcement_email
      end
    end
  end

  # send email for new announcement
  def send_announcement_email
    self.send_at = Time.zone.now
    save!
    UserMailer.announcement_notice(self).deliver
  end

  private
    def set_position
      if self.current_state == 3
        self.position = (Describe.new(Announcement).published.count)+1
        # self.position = (Announcement.published.count)+1
      else
        self.position = nil
      end
    end
end
