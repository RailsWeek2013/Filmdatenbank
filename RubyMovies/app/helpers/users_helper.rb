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

	def admin_moderator_signed_in?
		if user_signed_in?
			if current_user.moderator? || current_user.admin?
				return true
			end
		end
		false
	end

	def user_has_already_reviewed? film
		if user_signed_in?
			r = Review.where(film: film, user: current_user)
			return !r.empty?
		end
		false
	end

	def user_review film
		if user_signed_in?
			r = Review.where(film: film, user: current_user)
			return 0 if r.empty?
			return r.first.note
		end
		return 0
	end
end
