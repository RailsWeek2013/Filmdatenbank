class Blocklist < ActiveRecord::Base

	validates :user_id, :blocked_id, presence: true

	validates_uniqueness_of :user_id, :scope => :blocked_id

	def self.get_blocked_users user
		blocklist = Blocklist.where(user_id: user)
		users = Array.new
		blocklist.each do |blocked_user|
			users.push User.find(blocked_user.blocked_id)
		end
		users
	end

end
