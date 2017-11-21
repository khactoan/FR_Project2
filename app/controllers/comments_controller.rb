class CommentsController < ApplicationController
  before_action :set_comment, except: %i(index new create)
  before_action :load_post, only: %i(edit update)

  def create
    @post = Post.find_by id: comment_params[:post_id]
    @comments = Comment.comment_for_this_post(@post)
      .select_id_user_post_content_created_at_updated_at
      .order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = t ".Create comment successfully"
    else
      flash[:danger] = t ".Create comment failed"
    end

    redirect_to @post
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = t ".Update comment successfully"
    else
      flash[:danger] = t ".Update comment failed"
    end

    redirect_to @post
  end

  def destroy
    if @comment.destroy
      flash[:notice] = t ".Comment delete successfully"
    else
      flash[:danger] = t ".Create delete failed"
    end
    redirect_to @comment.post
  end

  private

  def set_comment
    @comment = Comment.find_by id: params[:id]
  end

  def load_post
    set_comment
    @post = @comment.post
  end

  def comment_params
    params.require(:comment).permit :user_id, :post_id, :content
  end
end
