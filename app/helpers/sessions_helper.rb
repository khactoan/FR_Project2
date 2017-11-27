module SessionsHelper
  def can_log_in_control_panel?
    user_signed_in? && current_user.is_admin
  end

  def can_comment? post
    if user_signed_in?
      if current_user.following? post.user
        return true
      elsif current_user == post.user
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
