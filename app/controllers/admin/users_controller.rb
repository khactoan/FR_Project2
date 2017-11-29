class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: %i(show update)

  def index
    @users = User.select_id_name_email_avatar.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def show
    @posts = @user.posts.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def update
    if current_user.valid_password? params[:user][:current_password]
      params[:user].delete(:password) if params[:user][:password].blank?

      if @user.update user_params
        if current_user == @user && current_user.password != @user.password
          flash[:success] = t "Your password has been changed"
          redirect_to :root
        else
          flash[:success] = t "Update user successfully"
          redirect_to admin_users_path
        end
      else
        flash[:danger] = t "Update user failed"
        redirect_to admin_user_path @user.id
      end
    else
      flash[:danger] = t "Update user failed. Your password is incorrect"
      redirect_to admin_user_path @user.id
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "User not found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :avatar,
      :date_of_birth
  end
end
