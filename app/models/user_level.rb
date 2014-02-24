class UserLevel < ActiveRecord::Base
  attr_accessible :level_id, :user_id
  
  belongs_to :user
  belongs_to :level

  public
  def progress
  	(user.experience * 100) / level.max_experience 
  end

end
