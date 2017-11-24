class Admin::PostsController < Admin::AdminController
  before_action :load_post, only: %i(destroy)

  def index
    @posts = Post.id_select_title_description_created_at_user
      .order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def destroy
    if @post.destroy
      flash[:success] = t "Post delete successfully"
      redirect_to :admin_posts
    else
      flash[:danger] = t "Post delete failed"
      redirect_to :admin_posts
    end
  end

  private

  def load_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = t "Post not found"
    redirect_to root_path
  end
end
