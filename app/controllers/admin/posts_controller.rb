class Admin::PostsController < Admin::AdminController
  before_action :load_post, only: %i(edit destroy update)

  def index
    @posts = Post.id_select_title_description_created_at_user
      .order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def update
    respond_to do |format|
      if @post.update post_params
        format.html {redirect_to @post,
          notice: t("Post was successfully updated.")}
      else
        format.html {render :edit}
      end
    end
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

  def post_params
    params.require(:post).permit :title, :description, :content, :tag_list
  end
end
