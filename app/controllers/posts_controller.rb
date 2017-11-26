class PostsController < ApplicationController
  require "will_paginate/array"

  before_action :set_post, except: %i(index new create)
  before_action :authenticate_user!, except: %i(index show)

  def index
    if params[:search] == nil
      @posts = Post.all
    else
      @posts = Post.where "title like ?", "%" + params[:search] + "%"
    end

    if params[:tag]
      @posts = @posts.tagged_with(params[:tag])
        .paginate :page => params[:page], :per_page => Settings.per_page
    else
      @posts = @posts.paginate :page => params[:page],
        :per_page => Settings.per_page
    end
  end

  def interested
    @posts = Post.interested_posts(current_user.id)
      .paginate :page => params[:page], :per_page => Settings.per_page
  end

  def new
    @post = Post.new
  end

  def destroy
    if @post.destroy
      flash[:success] = t "Post has been deleted"
      redirect_to :root
    else
      flash.now[:danger] = t "Post delete failed"
      render :show
    end
  end

  def create
    @post = Post.new post_params

    respond_to do |format|
      if @post.save
        format.html {redirect_to @post,
          notice: t(".Post was successfully created.")}
      else
        format.html {render :new}
      end
    end
  end

  def show
    @comments = Comment.comment_for_this_post(@post)
      .select_id_user_post_content_created_at_updated_at
      .order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
    @comment = Comment.new
  end

  def update
    respond_to do |format|
      if @post.update post_params
        format.html {redirect_to @post,
          notice: t(".Post was successfully updated.")}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html {redirect_to posts_url,
        notice: t(".Post was successfully destroyed.")}
    end
  end

  private

  def set_post
    @post = Post.find_by id: params[:id]
  end

  def post_params
    params.require(:post).permit :title, :description, :content, :user_id,
      :tag_list
  end
end
