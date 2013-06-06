class Category < ActiveRecord::Base
  attr_accessible :name, :scripture_list, :scripture_list_array

  has_and_belongs_to_many :scriptures

  def scripture_list_array=(ids)
    self.scripture_list = ids.join(',')
  end

  # turn into array
  def scripture_list_array
    new_array = []
    if self.scripture_list
      if self.scripture_list.length > 0
        group_array = self.scripture_list.split(',').to_a
        group_array.each do |g|
          new_array.push(g.to_i)
        end
      end
    end
      
    return new_array
  end

end
