class UsersController < ApplicationController
  before_action :load_user, only: %i(show destroy)

  def index
    @users = User.select_id_name_email_avatar.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def show
    @users = User.select_others(@user).select_id_name_email_avatar
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def destroy
    @user.destroy
    flash[:success] = t ".User detroy successfully"
    redirect_to :admin_users
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "User not found"
    redirect_to :root
  end
end
