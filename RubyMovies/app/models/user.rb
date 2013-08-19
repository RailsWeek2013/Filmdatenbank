class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_many :comments
	has_many :reviews
	has_many :films, through: :reviews

	# Informationen zur Handhabung mehrmaliger Assoziation mit der selben Tabelle aus:
	# http://www.spacevatican.org/2008/5/6/creating-multiple-associations-with-the-same-table/
	has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
	has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'

	belongs_to :role


	def admin?
		self.role.name == "Admin"
	end

	def moderator?
		self.role.name == "Moderator"
	end

	def user?
		self.role.name == "User"
	end
end