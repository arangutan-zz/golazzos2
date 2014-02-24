class Level < ActiveRecord::Base
  attr_accessible :max_experience, :min_experience, :title, :step

  has_many :userLevels
  has_many :users, through: :userLevels

  default_scope {order("step asc")}

  def self.find_level_by_experience(experience)
  	self.where("min_experience <= ? and ? <= max_experience", experience, experience)
  end
end
