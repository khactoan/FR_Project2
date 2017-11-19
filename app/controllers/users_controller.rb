class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    @users = User.all
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "User not found"
    redirect_to root_path
  end
end
