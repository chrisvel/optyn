class MessagesController < BaseController
  include Messagecenter::CommonsHelper

  before_filter :populate_user_folder_count

  before_filter :show_my_messages_only, :only => [:show]

  helper_method :registered_action_location

  def inbox
    @inbox_message_users = MessageUser.inbox_messages(current_user, @page)
    @inbox_messages = @inbox_message_users.collect(&:message).sort { |message1, message2| message1.send_on == message2.send_on ? message1.id <=> message2.id : message2.send_on <=> message1.send_on }
  end

  def saved
    @saved_message_users = MessageUser.saved_messages(current_user, @page)
    @saved_messages = @saved_message_users.collect(&:message).sort { |message1, message2| message1.send_on == message2.send_on ? message1.id <=> message2.id : message2.send_on <=> message1.send_on }
  end

  def trash
    @trash_message_users = MessageUser.trash_messages(current_user, @page)
    @trash_messages = @trash_message_users.collect(&:message).sort { |message1, message2| message1.send_on == message2.send_on ? message1.id <=> message2.id : message2.send_on <=> message1.send_on }
  end

  def show
    if !@message_user.blank? && !@message_user.is_read
      @message_user.update_attribute(:is_read, true)
      populate_user_folder_count(true)
    end
  end

  def move_to_inbox
    @messages = Message.for_uuids(uuids_from_message_ids)
    MessageUser.mark_inbox(@messages, [current_user])
    populate_user_folder_count(true)
    redirect_to inbox_messages_path
  end

  def move_to_trash
   @messages = Message.for_uuids(uuids_from_message_ids)
   MessageUser.mark_deleted(@messages, [current_user])
   populate_user_folder_count(true)
   redirect_to inbox_messages_path
  end

  def move_to_saved
    @messages = Message.for_uuids(uuids_from_message_ids)
    MessageUser.mark_saved(@messages, [current_user])
    populate_user_folder_count(true)
    redirect_to saved_messages_path
  end

  def discard
    @messages = Message.for_uuids(uuids_from_message_ids)
    MessageUser.mark_discarded(@messages, [current_user])
    populate_user_folder_count(true)
    redirect_to inbox_messages_path
  end

  private
  def populate_user_folder_count(force=false)
    @inbox_count = MessageUser.cached_user_inbox_count(current_user, force)
  end

  def show_my_messages_only
    @message = Message.find_by_uuid(params[:id])
    @message_user = @message.message_user(current_user)
    if @message_user.blank?
      redirect_to(inbox_messages_path)
      false
    end
  end

  def registered_action_location
    eval("#{registered_action}_messages_path(:page => #{@page || 1})")
  end
end
