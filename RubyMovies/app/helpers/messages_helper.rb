module MessagesHelper
	def new_message_count
		Message.where(recipient: current_user, deleted_by_recipient: false).count
	end
end
