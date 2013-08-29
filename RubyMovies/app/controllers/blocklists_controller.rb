class BlocklistsController < ApplicationController

	authorize_resource

	def index
		@users = Blocklist.get_blocked_users current_user
	end

	def destroy
		Blocklist.where(user_id: current_user.id, blocked_id: params[:blocked_user]).take.destroy
		redirect_to blocklist_path, notice: "Eintrag erfolgreich entfernt."
	end

end
