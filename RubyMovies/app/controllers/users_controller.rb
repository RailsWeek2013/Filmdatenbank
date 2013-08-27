class UsersController < ApplicationController
  authorize_resource

  before_action :set_user, only: [:promote, :update, :destroy]

  def promote
  end

  def list
  	@users = User.get_users
    @moderators = User.get_moderators
    @admins = User.get_admins
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :back, notice: "Der Benutzer wurde erfolgreich geändert."
    else
      redirect_to :back, notice: "Es ist ein Problem beim Speichern des Benutzers aufgetreten."
    end
  end

  def destroy
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
