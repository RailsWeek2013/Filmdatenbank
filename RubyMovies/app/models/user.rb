class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :comments
	has_many :reviews
	has_many :films, through: :reviews
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