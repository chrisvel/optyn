require 'encryptor'
require 'shop_timezone'

class MessageMailer < ActionMailer::Base
  include MailerFragmentCaching
  default from: 'Email <email@optyn.com>',
          reply_to: "services@optyn.com"
          
  helper "merchants/messages"
  helper "message_mailer_forgery"
  helper "application"

  def send_announcement(message, receiver)
    @message = message
    @receiver = receiver
    @show_cancel_link = false
    @user = @receiver #for survey emails
    @message_user = @receiver
    @shop = @message.shop
    if @message.manager.present?
      @shop = @message.shop
      @shop_logo = true #flag set for displaying the shop logo or just the shop name
    end
    ShopTimezone.set_timezone(@shop)

    @partner = @shop.partner

    #to: "success@simulator.amazonses.com",
    mail(to: %Q(#{@receiver.full_name + ' ' if @receiver.full_name}<#{@receiver.email}>),
      from: @message.from, 
      subject: @message.personalized_subject(@receiver),
      reply_to: @message.manager_email
      ) 
  end

  def send_template(message, receiver)
    ShopTimezone.set_timezone(message.shop)
    template = message.template
    unparsed_content = template.fetch_cached_content(message)
    content = template.personalize_body(unparsed_content, message, receiver)
    content = template.process_urls(content, message, receiver)
    content = template.process_content(content, receiver)
    mail(to: %Q(#{receiver.full_name + ' ' if receiver.full_name}<#{receiver.email}>),
      from: message.from, 
      subject: message.personalized_subject(receiver),
      reply_to: message.manager_email,
      content_type: 'text/html',
      body: content
    ) 
  end

  def error_notification(error_message)
    mail(to: ["gaurav@optyn.com", "alen@optyn.com"], subject: "Error while sending emails", body: error_message)
  end

  def shared_email(user_email, message)
    @message = message
    @shop = @message.shop
    ShopTimezone.set_timezone(@shop)
    @user_email = user_email
    mail(to: user_email, subject: "#{@message.name}")

    mail(to: user_email,
      from: @message.from,
      subject: @message.personalized_subject(user_email),
      reply_to: @message.manager_email
      ) 
  end

  def send_change_notification(message_change_notifier)
    @message_change_notifier = message_change_notifier
    @message_content = @message_change_notifier.content
    @actual_message = @message_change_notifier.message
    @owner_shop = @actual_message.shop
    @access_token = @message_change_notifier.access_token

    ShopTimezone.set_timezone(@owner_shop)

    mail(from: "services@optyn.com",
      to: SiteConfig.eatstreet_curation_email,
      cc: ["gaurav@optyn.com", "alen@optyn.com", "ian@eatstreet.com"],
      subject: "Message Curation: #{@owner_shop.name}",
      reply_to: @actual_message.manager_email
    )
  end

  def send_rejection_notification(message_change_notifier)
    @message_change_notifier = message_change_notifier
    @message_content = @message_change_notifier.content
    @actual_message = @message_change_notifier.message
    @owner_shop = @actual_message.shop
    ShopTimezone.set_timezone(@shop)
    
    mail(
      from: "specials@eatstreet.com",
      to: Rails.env.staging? ? SiteConfig.eatstreet_curation_email : @actual_message.manager_email,
      bcc: ["gaurav@optyn.com", "alen@optyn.com", "ian@eatstreet.com"],
      subject: "Message Rejected: #{@actual_message.name}",
      reply_to: "specials@eatstreet.com"
    )
  end
end