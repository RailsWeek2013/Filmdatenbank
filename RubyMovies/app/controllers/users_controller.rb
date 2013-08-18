class UsersController < ApplicationController
  authorize_resource


  def promote
  	@user = User.find(params[:u])
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

  private
  def user_params
    params.require(:user).permit("role_id")
  end

end
