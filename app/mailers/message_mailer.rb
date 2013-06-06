class MessageMailer < ActionMailer::Base
  default from: '"Email" <email@optyn.com>'
  helper "merchants/messages"
  helper "message_mailer_forgery"

  def send_announcement(message, message_user)
    @message = message
    @message_user = message_user

    mail(to: %Q(#{@message_user.name} <#{@message_user.email}>), subject: @message.personalized_subject(@message_user))
  end

  def error_notification(error_message)
    mail(to: ["gaurav@optyn.com", "alen@optyn.com"], subject: @message.personalized_subject(@message_user), body: error_message)
  end
end