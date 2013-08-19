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
      notice: "Favorit wurde erfolgreich geändert."
    else
      render action: "edit"
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

  #def delete
  #  user = User.all.find(params[:id])
  #  user.delete
  #  redirect_to manageUser_url,
  #  notice: "Favorit wurde erfolgreich gelöscht."
  #end

  private
  def user_params
    params.require(:user).permit("role_id")
  end

  def set_user
    @user = User.find(params[:id])
  end
end
