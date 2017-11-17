class PostsController < ApplicationController
  before_action :set_post, except: %i(index new create)

  def index
    @posts = Post.paginate :page => params[:page], :per_page => Settings.per_page
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def set_post
    @post = Post.find_by id: params[:id]
  end

  def post_params
    params.require(:post).permit :title, :description, :content, :user_id
  end
end
