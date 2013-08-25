class Blocklist < ActiveRecord::Base

	validates :user_id, :blocked_id, presence: true
	#validates :user_id, uniqueness: { scope: :blocked_id}

	validates_uniqueness_of :user_id, :scope => :blocked_id

end
