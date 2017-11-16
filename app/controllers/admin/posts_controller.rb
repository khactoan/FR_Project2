class Admin::PostsController < ApplicationController
  before_action :set_admin_post, expect: %i(index new create)

  def index
    @admin_posts = Admin::Post.all
  end

  def show; end

  def new
    @admin_post = Admin::Post.new
  end

  def edit; end

  def create
    @admin_post = Admin::Post.new admin_post_params

    respond_to do |format|
      if @admin_post.save
        format.html {redirect_to @admin_post, notice: "Post was successfully created."}
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_post.update(admin_post_params)
        format.html {redirect_to @admin_post, notice: "Post was successfully updated."}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @admin_post.destroy
    respond_to do |format|
      format.html {redirect_to admin_posts_url, notice: "Post was successfully destroyed."}
    end
  end

  private

  def set_admin_post
    @admin_post = Admin::Post.find params[:id]
  end

  def admin_post_params
    params.require(:admin_post).permit :title, :content, :user_id
  end
end
