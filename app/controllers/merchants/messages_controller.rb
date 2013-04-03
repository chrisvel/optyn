class Merchants::MessagesController < Merchants::BaseController
  before_filter :populate_message_type, :populate_labels, only: [:new, :create, :edit, :update]

  def types
    #Do Nothing
  end

  def new
    @message = Message.new
    @message.manager_id = current_manager.id
  end

  def create
    Message.transaction do
      klass = params[:message_type].classify.constantize
      @message = klass.new(params[:message])
      @message.manager_id = current_manager.id
      if @message.send(params[:choice].to_sym)
        message_redirection
      else
        render "new"
      end
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    Message.transaction do
      klass = params[:message_type].classify.constantize
      @message = klass.find(params[:id])
      @message.manager_id = current_manager.id
      @message.attributes = params[:message]

      if @message.send(params[:choice].to_sym)
        message_redirection
      else
        render "edit"
      end
    end
  end

  private
  def populate_message_type
    @message_type = Message.fetch_template_name(params[:message_type])
  end

  def populate_labels
    @labels = current_shop.labels.active_and_inactive(current_shop)
  end

  def message_redirection
    choice = params[:choice]
    if "preview" == choice
      #TODO TO BE IMPLEMENTED TO BE REDIRECTED TO THE SHOW PAGE.
    elsif "launch" == choice
      #TODO TO BE IMPLEMENTED TO BE REDIRECTED TO THE SENT PAGE.
    else
      redirect_to edit_merchants_message_path(@message.id)
    end
  end
end
