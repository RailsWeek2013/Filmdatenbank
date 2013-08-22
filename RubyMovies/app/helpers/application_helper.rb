module ApplicationHelper
	def back
		#http://webjazz.blogspot.de/2007/02/link-back-to-referring-page-in-rails.html
		link_to "Zurück", request.env["HTTP_REFERER"] 
	end

	def link_to_signed_in name, path
		if user_signed_in?
			link_to_unless_current name, path
		end
	end

	def link_to_admin_mod name, path
		if admin_signed_in? || moderator_signed_in?
			link_to_unless_current name, path
		end
	end

	def messagelinkdisabled?
		if current_page?(controller: 'messages', action: 'outbox') || 
			current_page?(controller: 'messages', action: 'new') || 
			current_page?(controller: 'messages', action: 'index')
                    return true
        end
        false
	end
end
