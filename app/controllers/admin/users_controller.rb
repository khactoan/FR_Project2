class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: :show

  def index
    @users = User.select_id_name_email_avatar.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def show
    @posts = @user.posts
  end

  def update

  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "User not found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :avatar
  end
end
