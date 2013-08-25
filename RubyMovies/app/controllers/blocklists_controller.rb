class BlocklistsController < ApplicationController

	authorize_resource

	def index
		values = Blocklist.where(user_id: current_user)
		@users = Array.new
		values.each do |blocklist|
			@users.push User.find(blocklist.blocked_id)
		end
	end

	def destroy
		Blocklist.where(user_id: current_user.id, blocked_id: params[:blocked_user]).first.destroy
		redirect_to blocklist_path, notice: "Eintrag erfolgreich entfernt."
	end

end
