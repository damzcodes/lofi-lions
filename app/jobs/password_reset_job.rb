class PasswordResetJob < ActiveJob::Base
  queue_as :default

  def perform
  #  CronMailer.password_reset(@user).deliver_later
  end

  #MyJob.perform_later record
end
