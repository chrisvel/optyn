module ApplicationHelper
  
  def user_present?
    user_signed_in? || merchants_manager_signed_in?
  end

  def has_locations?
    manager = current_merchants_manager
    manager && manager.shop.stype=="local" && !manager.shop.locations.any?
  end

end
