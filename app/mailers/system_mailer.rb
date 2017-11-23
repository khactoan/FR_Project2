class SystemMailer < ApplicationMailer
  default from: "khactoan96@gmail.com"

  def comment_email comment, post
    @comment = comment
    @post = post
    mail to: @post.user.email,
      subject: "You have a new comment on " + @comment.post.title.to_s
  end

  def sign_up_email user
    @user = user
    mail to: @user.email, subject: "Sign up Project2 successfully"
  end
end
