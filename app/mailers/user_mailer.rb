class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    f = params[:format]
    @url = users_url
    attachments['profile'] = File.read(Rails.root.join("public#{@user.profile_url}"))
    mail(to: @user.email, subject: 'Welcome to users list') do |format|
      f == 'html' ? format.html : format.text
    end
  end

  def change_email
    @user = params[:user]
    @old_email = params[:past_email]
    @url = users_url
    attachments['profile'] = File.read(Rails.root.join("public#{@user.profile_url}"))
    mail(to: @user.email, subject: 'Changed email address') do |format|
      format.html { render layout: 'changed_email_layout' }
    end
  end
end
