class Admin::UsersController < Admin::AdminController
  def index
    @users = User.select_id_name_email_avatar.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end
end
