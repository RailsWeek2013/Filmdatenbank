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

	validates :name, presence: true
	validates_uniqueness_of :name

	def admin?
		self.role.name == "Admin"
	end

	def moderator?
		self.role.name == "Moderator"
	end

	def user?
		self.role.name == "User"
	end

	def add_to_blocklist user_id
		b = Blocklist.new
		b.user_id = self.id
		b.blocked_id = user_id
		b.save
	end

	def is_allowed_to_send? recipient_id
		if Blocklist.where(user_id: recipient_id, blocked_id: self.id).empty?
			return true
		else
			false
		end
	end

	def self.get_users
		ur = Role.find_by name: "User"
		User.where("role_id = ?", ur.id).order(name: :asc)
	end

	def self.get_moderators
		mr = Role.find_by name: "Moderator"
		User.where("role_id = ?", mr.id).order(name: :asc)
	end

	def self.get_admins
		ar = Role.find_by name: "Admin"
		User.where("role_id = ?", ar.id).order(name: :asc)
	end
end