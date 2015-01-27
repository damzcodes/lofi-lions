class CronMailer < ActionMailer::Base
  default from: ENV["CRON_EMAIL_FROM"] || "cron@example.com"

  def translation_status_report
    @languages = Language.includes(:localized_texts).order(:name)
    mail(to: admins, subject: "Translation status #{Date.today.to_s(:long)}")
  end

  def password_reset(user)
    @user = user
    @url  = 'http://example.com/password_reset'
    mail(to: @user.email, subject: 'Password Reset Link')
  end

  protected

  def admins
    admin_users.map(&:email)
  end

  def admin_users
    User.admins
  end
end
