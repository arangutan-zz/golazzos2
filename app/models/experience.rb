class Experience
	attr_reader :user, :from
	def initialize(args)
		@user = args.fetch(:to, nil)
		@from = args.fetch(:from, nil)

		add_experience
		find_level
	end
	
	public

	private
	def add_experience
		case from
		when :bet
			user.experience += 5
		when :facebook_share
			user.experience += 3
		else
			user.experience += 1
		end
	end	
	def find_level
		level = Level.find_level_by_experience user.experience
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