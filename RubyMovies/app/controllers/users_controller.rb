class UsersController < ApplicationController
  authorize_resource

  def promote
  	@user = User.find(params[:id])
  end

  def list
  	ur = Role.find_by name: "User"
  	mr = Role.find_by name: "Moderator"
  	ar = Role.find_by name: "Admin"

  	@users = User.where("role_id = ?", ur.id)
    @moderators = User.where("role_id = ?", mr.id)
    @admins = User.where("role_id = ?", ar.id)
  end

  def update
    @user = User.all.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :back,
      notice: "Der Benutzer wurde erfolgreich geändert."
    else
      redirect_to :back,
      notice: "Es ist ein Problem beim Speichern des Benutzers aufgetreten."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to manageUser_url }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit("role_id")
  end

  def set_user
    @user = User.find(params[:id])
  end
end
