class Invitation < ActiveRecord::Base
  attr_accessible :sender_id, :recipient_uid, :token, :sent_at, :used, :demora, :created_at

	belongs_to :sender, :class_name => 'User'
	has_one :recipient, :class_name => 'User'

	validates_presence_of :recipient_uid
	validate :recipient_is_not_registered
	#validate :sender_has_invitations, :if => :sender

	#before_create :generate_token
	#before_create :decrement_sender_count, :if => :sender
	#ADDED: incrementa las invitaciones
	#before_create :increment_sender_count, :if => :sender

	def actualizar_used
    	usedT = true
    	#self.used = true
    	self.update_attributes(used: usedT)
  	end
  	def actualizar_demora
    	demoraT = (Time.now - self.created_at.to_time)/1.day
    	#self.demora = demoraT
    	self.update_attribute(:demora, demoraT)
    	#self.update_attributes(demora: demoraT)
  	end
	private
 
	def recipient_is_not_registered
	  errors.add :recipient_uid, 'is already registered' if User.find_by_uid(recipient_uid)
	end

	# def sender_has_invitations
	#   unless sender.invitation_limit > 0
	#     errors.add_to_base 'You have reached your limit of invitations to send.'
	#   end
	# end

	#def generate_token
	#  self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	#end
	# def decrement_sender_count
	#   sender.decrement! :invitation_limit
	# end
end
