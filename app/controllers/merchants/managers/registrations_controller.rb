class Merchants::Managers::RegistrationsController < Devise::RegistrationsController

  before_filter :require_customer_logged_out
  helper_method :current_shop
  
  def new
    session[:omniauth_manager] = true
    session[:omniauth_user] = nil
    @shop = Shop.new
    @shop.managers.build
  end

  def create 
    shop_name = params[:shop_name][:name].to_s.downcase
    @shop = Shop.new
    @shop.attributes = params[:shop_name]

    if @shop.managers.size > 1
      @shop.managers.shift
    end

    @manager = @shop.managers.first
    @manager.skip_password = true if params[:auth_id].present? && params[:auth_provider].present?

    clear_session_anyone_logged_in

    shop_created = (@shop.deleted? || @shop.new_record?) ? (@shop.new_record? ? @shop.save : @shop.recover) : @shop.valid?
    if shop_created
      @shop.update_manager
      @shop.managers.first.create_authentication(params[:auth_id], params[:auth_provider]) if params[:auth_id].present?
      sign_in(@shop.managers.first)
      flash[:notice] = "Merchant account created successfully"
      redirect_to after_sign_in_path_for(nil) 	
    else
      flash[:alert] = "Could not sign-up"
      @omniauth={:uid => params[:auth_id],:provider => params[:auth_provider]} if params[:auth_id].present?
      @shop.errors[:name] << "Business with entered details exists already" if @shop.shop_already_exists?
      render 'new'
    end

  end

  private
  def current_shop
    current_merchants_manager.shop if merchants_manager_signed_in?
  end  
end
