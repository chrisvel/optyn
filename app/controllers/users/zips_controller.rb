class Users::ZipsController < BaseController
  before_filter :update_zip_prompted

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @user.attributes = params[:user]
    if @user.create_or_update_zips(params[:user])
      redirect_to connections_path
    else
      render 'new'
    end
  end

  private
  def update_zip_prompted
    unless current_user.zip_prompted
      current_user.update_zip_prompted(true)
    end
  end
end