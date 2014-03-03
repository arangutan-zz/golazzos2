class Experience
	attr_reader :user, :from, :subject
	def initialize(args)
		@user = args.fetch(:to, nil)
		@from = args.fetch(:from, nil)
		@bet  = args.fetch(:subject, nil)
		add_experience
		find_level
	end
	
	public
	def self.all
		{ facebook_share: 3, bet: 5, otro: 1}
	end


	private
	def add_experience
		user.experience += from.pezzos_ganados if subject and subject.respond_to :pezzos_ganados
		user.experience += Experience.all.fetch(from, 0)
		user.save
	end	
	def find_level
		level = Level.find_by_experience user.experience
		mark_user_new_level(level.first)
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