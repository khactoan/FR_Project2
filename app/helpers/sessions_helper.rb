module SessionsHelper
  def can_log_in_control_panel?
    user_signed_in? && current_user.is_admin
  end
end
