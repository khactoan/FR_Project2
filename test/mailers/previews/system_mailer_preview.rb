class SystemMailerPreview < ActionMailer::Preview
  def comment_mail_preview
    SystemMailer.comment_email(User.first)
  end
end
