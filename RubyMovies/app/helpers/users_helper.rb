module UsersHelper
	def admin_signed_in?
		if user_signed_in?
			if current_user.admin?
				return true
			end
		end
		false
	end

	def moderator_signed_in?
		if user_signed_in?
			if current_user.moderator?
				return true
			end
		end
		false
	end
end
