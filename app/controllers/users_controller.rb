class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    @users = User.all
  end

  def show
    @users = User.select_others(@user).select_id_name_email_avatar
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "User not found"
    redirect_to root_path
  end
end
