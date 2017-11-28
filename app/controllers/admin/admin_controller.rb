class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :check_admin?

  private

  def check_admin?
    return if user_signed_in? && current_user.is_admin
    flash[:alert] = t "Only admin has access for this action"
    redirect_to :root
  end
end
