class Merchants::TemplateUploadsController < Merchants::BaseController
  http_basic_authenticate_with name: "", password: "9p5yn123"

  def new
    @template_upload = @template_upload = TemplateUpload.new
    @message = Message.select(:uuid).find_by_uuid(params[:message_id])
  end

  def create
    @template_upload = TemplateUpload.new
    @template_upload.manager_id = current_manager.id
    @template_upload.template_html_file = params[:merchants_template_upload][:template_html_file].read rescue nil
    if @template_upload.save
      @template_upload.save_content
      redirect_to "/merchants/messages/#{params[:message_id]}/template"
    else
      @message = Message.select(:uuid).find_by_uuid(params[:message_id])
      render :new
    end
  end
end
