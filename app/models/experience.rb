class Experience
	attr_reader :user, :from
	def initialize(args)
		@user = args.fetch(:to, nil)
		@from = args.fetch(:from, nil)

		add_experience
		find_level
	end
	
	public
	def self.all
		{
			bet: 5,
			facebook_share: 3,
			otro: 1
		}
	end


	private
	def add_experience
		user.experience+= all.fetch(from, 10)
	end	
	def find_level
		level = Level.find_by_experience user.experience
		mark_user_new_level(level)
	end
	def mark_user_new_level(level)
		if user.level.title == level.title
			user.new_level= false
		else
			user.new_level= true
		end
		user.level= level
	end
end