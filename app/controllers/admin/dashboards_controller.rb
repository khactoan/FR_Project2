class Admin::DashboardsController < Admin::AdminController
  def index
    if !params[:time_range].nil?
      @time_range = params[:time_range]
      start_time = @time_range.split(" - ")[0].to_date
      end_time = @time_range.split(" - ")[1].to_date
      @posts = Post.created_between start_time, end_time
      @comments = Comment.created_between start_time, end_time
      @users = User.created_between start_time, end_time
      @tags = Tagging.select_distinct_tag_id.created_between start_time, end_time
    else
      @posts = Post.all
      @comments = Comment.all
      @users = User.all
      @tags = Tagging.select_distinct_tag_id
    end
  end
end
